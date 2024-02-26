import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '/game/wildrun.dart';
import '/game/enemy.dart';
import '/game/audio_manager.dart';
import '/game/blowingball.dart';
import '/models/player_data.dart';

enum PlayerAnimationStates {
  idle,
  walk,
  run,
  hit,
  attack,
  death,
  jump,
  fly,
}

class Player extends SpriteAnimationGroupComponent<PlayerAnimationStates>
    with CollisionCallbacks, HasGameReference<WildRun> {
  static final _animationMap = {
    // map animation for player
    PlayerAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 2,
      stepTime: 0.1,
      textureSize: Vector2.all(32),
    ),
    PlayerAnimationStates.walk: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(0, (2) * 32),
    ),
    PlayerAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.05,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(0, (3) * 32),
    ),
    PlayerAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.1,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(32, (6) * 32),
    ),
    PlayerAnimationStates.attack: SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.1,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(0, (8) * 32),
    ),
    PlayerAnimationStates.death: SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.5,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(0, (7) * 32),
    ),
    PlayerAnimationStates.jump: SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.5,
      textureSize: Vector2.all(32),
      texturePosition: Vector2(0, (5) * 32),
    ),
    PlayerAnimationStates.fly: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.2,
      textureSize: Vector2.all(32),
      texturePosition: Vector2((2) * 32, (5) * 32),
    ),
  };
  double yMax = 0.0;
  double speedY = 0.0;
  bool hasJumped = true;

  final Timer _hitTimer = Timer(0.5);
  final Timer _attackTimer = Timer(1);
  static const double gravity = 700;
  final PlayerData playerData;
  late final SpawnComponent _ballSpawner;

  bool isHit = false;
  bool isAttack = false;

  Player(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    _reset();
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    yMax = y;

    _hitTimer.onTick = () {
      current = PlayerAnimationStates.run;
      isHit = false;
    };
    _attackTimer.onTick = () {
      current = PlayerAnimationStates.run;
      isAttack = false;
    };

    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    print("player has loaded");
    position = game.size / 2;
    _ballSpawner = SpawnComponent(
      period: .5,
      selfPositioning: true,
      factory: (index) {
        return GlowingBall(
          position: position +
              Vector2(
                0,
                0,
              ),
        );
      },
      autoStart: false,
    );
    game.add(_ballSpawner);
  }

  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.attack)) {
        current = PlayerAnimationStates.run;
      }
    }
    _hitTimer.update(dt);
    _attackTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy && !isHit) {
      if (!isAttack) {
        hit();
      }
      if (isAttack) {
        attack();
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (y >= yMax);
  void jump() {
    if (isOnGround) {
      speedY = -300;
      hasJumped = true;
    }
    if (!isOnGround && hasJumped) {
      speedY = -250;
      hasJumped = false;
    }
    current = PlayerAnimationStates.jump;
    AudioManager.instance.playSfx('jump14.wav');
  }

  void attack() {
    current = PlayerAnimationStates.attack;
    _attackTimer.start();
    startAttack();
  }

  void startAttack() {
    _ballSpawner.timer.start();
    print('attack');
  }

  void stopAttack() {
    _ballSpawner.timer.stop();
  }

  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = PlayerAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, game.virtualSize.y - 22);
    size = Vector2.all(24);
    current = PlayerAnimationStates.run;
    isHit = false;
    isAttack = false;
    speedY = 0.0;
  }
}
