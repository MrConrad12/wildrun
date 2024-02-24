import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '/game/wildrun.dart';
import '/game/enemy.dart';
import '/game/audio_manager.dart';
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
      stepTime: 0.2,
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

  final Timer _hitTimer = Timer(1);
  static const double gravity = 700;
  final PlayerData playerData;

  bool isHit = false;

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

    super.onMount();
  }

  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run)) {
        current = PlayerAnimationStates.run;
      }
    }
    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (y >= yMax);
  void jump() {
    if (isOnGround) {
      speedY = -300;
      current = PlayerAnimationStates.jump;
      //AudioManager.instance.playSfx(''); // adding sfx
    }
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
    speedY = 0.0;
  }
}
