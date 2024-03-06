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
import 'package:wildrun/game/actors/player_animation.dart';

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
  bool canPlant = false;

  Player(Image image, this.playerData)
      : super.fromFrameData(image, animationMap);

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
          (current != PlayerAnimationStates.plant)) {
        current = PlayerAnimationStates.run;
      }
    }
    touchPlatform = false;
    canPlant = false;

    _effectTimer.update(dt);
    _flyTimer.update(dt);

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    entityInteraction(other);
    decorationInteraction(intersectionPoints, other);
    super.onCollision(intersectionPoints, other);
  }

  // check if we are hitting a platform
  void decorationInteraction(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Decoration) && (other.typeBlock == TypeBlock.platform)) {
      if (speedY >= 0 && intersectionPoints.elementAt(0).y >= height / 3) {
        current = PlayerAnimationStates.run;
        if (!isJump) {
          touchPlatform = true;
          speedY = 0;
          y = other.y - other.height / 2 + 3.5;
        }
      }
    }
  }

  //  check if the player is interacting with an enemy and apply animation
  void entityInteraction(PositionComponent other) {
    if (other is Entity) {
      switch (other.typeBlock) {
        case TypeBlock.enemyCO2:
        case TypeBlock.spiked:
        case TypeBlock.enemyRadioactive:
          if (!isHit) {
            hit();
          }
          break;
        case TypeBlock.wolf:
          playerData.nbAnimal += 1;
          break;
        case TypeBlock.bird:
          if (!isFly) {
            fly();
          }
          break;
        case TypeBlock.fruit:
          if (!isHeal) {
            heal();
          }
          break;
        case TypeBlock.waste:
          regeneAttack();
          break;
        case TypeBlock.seed:
          getSeed();
          break;
        case TypeBlock.arrowTree:
          plantTree();
          break;
        default:
          break;
      }
    }
  }

  void plantTree() {
    if (playerData.seed > 0) {
      current = PlayerAnimationStates.plant;
      _effectTimer.start();
      playerData.seed -= 1;
    }
  }

  void regeneAttack() {
    playerData.attack += 1;
    playerData.nbWaste += 1;
  }

  void _applyGravity(double dt) {
    speedY += gravity * dt;
  }

  void jump() {
    if (isOnGround || touchPlatform) {
      speedY = -250;
      hasJumped = true;
    }
    if (!isOnGround && hasJumped && !touchPlatform) {
      speedY = -250;
      hasJumped = false;
    }
    isJump = false;
    touchPlatform = false;
    current = PlayerAnimationStates.jump;
    AudioManager.instance.playSfx('jump14.wav');
  }

  void attack() {
    if (playerData.attack > 0) {
      game.world.add(GlowingBall());
    }
    _effectTimer.start();
    playerData.attack -= 1;
  }

  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = PlayerAnimationStates.hit;
    playerData.lives -= 1;
    _effectTimer.start();
  }

  void fly() {
    isFly = true;
    speedY = 0;
    hasJumped = true;
    playerData.nbAnimal += 1;
    //AudioManager.instance.playSfx(''); //song for flying
    current = PlayerAnimationStates.fly;
    _flyTimer.start();
  }

  void heal() {
    //AudioManager.instance.playSfx(''); //song for healing
    isHeal = true;
    playerData.lives += 1;
    _effectTimer.start();
  }

  void getSeed() {
    if (playerData.seed < 3) {
      playerData.seed += 1;
    }
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
    isHeal = false;
    isRecharge = false;
    isAttack = false;
    isJump = false;
    isFly = false;
    canPlant = false;
    hasJumped = false;
    touchPlatform = false;
    speedY = 0.0;
  }
}
