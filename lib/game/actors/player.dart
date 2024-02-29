import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import 'package:wildrun/game/objects/decoration.dart';
import 'package:wildrun/game/objects/entity.dart';

import '/game/wildrun.dart';
import '../managers/audio_manager.dart';
import '/models/player_data.dart';
import 'attack.dart';

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
  final Timer _flyTimer = Timer(3);
  static const double gravity = 710;
  final PlayerData playerData;

  // Flags for hit, heal, and attack states
  bool isHit = false;
  bool isJump = false;
  bool isHeal = false;
  bool isRecharge = false;
  bool isAttack = false;
  bool isFly = false;

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
      isFly = false;
    };
    _flyTimer.onTick = () {
      current = PlayerAnimationStates.run;
      isFly = false;
    };
    super.onMount();
  }

  // update method for updating player properties
  @override
  void update(double dt) {
    // apply gravity if the player isn't flying
    if (!isFly) {
      _applyGravity(dt);
    }
    if (!touchPlatform) {
      y += speedY * dt;
    }
    if (isOnGround) {
      y = yMax;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.fly) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.attack)) {
        current = PlayerAnimationStates.run;
      }
    }
    touchPlatform = false;

    // update all timers
    _effectTimer.update(dt);
    _flyTimer.update(dt);

    super.update(dt);
  }

  // onCollision method for handling collisions with other components
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    entityInteraction(other);
    decorationInteraction(intersectionPoints, other);
    super.onCollision(intersectionPoints, other);
  }

  //  check if we are hitting a platform
  void decorationInteraction(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Decoration) && (other.typeBlock == TypeBlock.platform)) {
      if (speedY >= 0 && intersectionPoints.elementAt(0).y >= height / 3) {
        current = PlayerAnimationStates.run;
        if (!isJump) {
          touchPlatform = true;
          speedY = 0;
          y = other.y - other.height / 2 + 5;
        }
      }
    }
  }

  //  check if the player is interacting with an enemy and apply animation
  void entityInteraction(PositionComponent other) {
    if ((other is Entity)) {
      if ((other.typeBlock == TypeBlock.wolf) && (!isHit)) {
        hit();
      }
      if ((other.typeBlock == TypeBlock.bird) && (!isFly)) {
        speedY = 0;
        hasJumped = true;
        fly();
      }
      if ((other.typeBlock == TypeBlock.fruit) && (!isHeal)) {
        heal();
      }
      if ((other.typeBlock == TypeBlock.waste) && (!isRecharge)) {
        playerData.attack += 1;
      }
    }
  }

  void _applyGravity(double dt) {
    speedY += gravity * dt;
  }

  // jump and double jump perform
  void jump() {
    if (isOnGround || touchPlatform) {
      speedY = -300;
      hasJumped = true;
    }
    if (!isOnGround && hasJumped && !touchPlatform) {
      speedY = -200;
      hasJumped = false;
    }
    isJump = false;
    touchPlatform = false;
    current = PlayerAnimationStates.jump;
    AudioManager.instance.playSfx('jump14.wav');
  }

  // attack perform
  void attack() {
    current = PlayerAnimationStates.attack;
    playerData.attack -= 1;
    if (playerData.attack >= 0) {
      game.world.add(GlowingBall());
    }
    _effectTimer.start();
  }

  // handling hit and set live player
  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = PlayerAnimationStates.hit;
    playerData.lives -= 1;
    _effectTimer.start();
  }

  // handling fly
  void fly() {
    isFly = true;
    //AudioManager.instance.playSfx(''); //song for flying
    current = PlayerAnimationStates.fly;
    _flyTimer.start();
  }

  // handling heal, add live
  void heal() {
    //AudioManager.instance.playSfx(''); //song for healing

    isHeal = true;
    playerData.lives += 1;
    _effectTimer.start();
  }

  // Resetting all player properties
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
    isRecharge = false;
    isAttack = false;
    isJump = false;
    isFly = false;
    hasJumped = false;
    touchPlatform = false;
    speedY = 0.0;
  }
}

// Static map for storing animation data
final _animationMap = {
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
    stepTime: 0.05,
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
    stepTime: 0.1,
    textureSize: Vector2.all(32),
    texturePosition: Vector2((2) * 32, (5) * 32),
  ),
};
