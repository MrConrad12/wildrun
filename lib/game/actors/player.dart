import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/objects/animals.dart';
import 'package:wildrun/game/objects/platform_block.dart';

import '/game/wildrun.dart';
import 'enemy.dart';
import '../managers/audio_manager.dart';
import '/models/player_data.dart';

// Enum for Player's animation states
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

// Player class representing the main character in the game
class Player extends SpriteAnimationGroupComponent<PlayerAnimationStates>
    with CollisionCallbacks, HasGameReference<WildRun> {
  // Static map for storing animation data
  static final _animationMap = {
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
  // Player's maximum y-coordinate
  double yMax = 0.0;

  // Current y-coordinate and speedY for vertical movement
  double currentY = 0.0;
  double speedY = 0.0;

  // Flags for jump-related actions
  bool hasJumped = false;
  bool touchPlatform = false;

  // Flag for checking if the player is on the ground
  bool get isOnGround => (y >= yMax);

  // Timer for various effects
  final Timer _effectTimer = Timer(.5);
  static const double gravity = 700;
  final PlayerData playerData;

  // Flags for hit, heal, and attack states
  bool isHit = false;
  bool isHeal = false;
  bool isAttack = false;

  // Constructor for Player class
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

    _effectTimer.onTick = () {
      current = PlayerAnimationStates.run;
      isHit = false;
      isHeal = false;
      isAttack = false;
    };
    super.onMount();
  }

  // update method for updating player properties
  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;
    if (isOnGround || touchPlatform) {
      y = touchPlatform ? currentY : yMax;
      speedY = 0.0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.attack)) {
        current = PlayerAnimationStates.run;
      }
    }

    touchPlatform = false;
    _effectTimer.update(dt);
    super.update(dt);
  }

  // onCollision method for handling collisions with other components
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    if ((other is Animal) && (!isHeal)) {
      heal();
    }
    super.onCollision(intersectionPoints, other);
    if ((other is PlatformBlock) && position.y <= other.posY - 10) {
      touchPlatform = true;
      currentY = y;
    }
  }

  // jump method for making the player jump
  void jump() {
    if (isOnGround || touchPlatform) {
      speedY = -300;
      hasJumped = true;
    }
    if (!isOnGround && hasJumped && !touchPlatform) {
      speedY = -250;
      hasJumped = false;
    }
    current = PlayerAnimationStates.jump;
    AudioManager.instance.playSfx('jump14.wav');
  }

  // attack method for making the player attack
  void attack() {
    current = PlayerAnimationStates.attack;
    _effectTimer.start();
  }

  // hit method for handling player hit events
  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = PlayerAnimationStates.hit;
    _effectTimer.start();
    playerData.lives -= 1;
  }

  // heal method for handling player heal events
  void heal() {
    isHeal = true;
    playerData.lives += 1;
    print("heal");
    _effectTimer.start();
  }

  // reset method for resetting player properties
  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, game.virtualSize.y - 22);
    size = Vector2.all(24);
    current = PlayerAnimationStates.run;
    isHit = false;
    isHeal = false;
    isAttack = false;
    speedY = 0.0;
  }
}
