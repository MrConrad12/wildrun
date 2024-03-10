import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/actors/attack.dart';
import 'package:wildrun/game/managers/mapping.dart';
import 'package:flame/effects.dart';
import '../actors/player.dart';
import '../managers/audio_manager.dart';
import '../wildrun.dart';
import 'tree.dart';

class Entity extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final String urlImg;
  late Vector2 gridPosition;
  late double xOffset;
  final Vector2 velocity = Vector2.zero();
  final Vector2 sizeElement;
  final Vector2 spriteSize;
  final int nbFrame;
  final double spriteTime;
  final int bonusScore;
  int live = 2;

  Entity({
    required this.typeBlock,
    required this.urlImg,
    required this.sizeElement,
    required this.spriteSize,
    required this.nbFrame,
    required this.spriteTime,
    required this.gridPosition,
    required this.xOffset,
    required this.bonusScore,
  }) : super(size: sizeElement, anchor: Anchor.center);

  @override
  void onLoad() {
    const double sizeBox = 32;
    double platformSize = 0;
    if (gridPosition.y > 1) {
      platformSize = 12;
    }
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(urlImg),
      SpriteAnimationData.sequenced(
        amount: nbFrame,
        textureSize: spriteSize,
        stepTime: spriteTime,
      ),
    );
    position = Vector2(
      (gridPosition.x * sizeBox) + xOffset,
      game.size.y - (gridPosition.y * sizeBox) - platformSize,
    );
    add(RectangleHitbox(collisionType: CollisionType.active));

    // Add some effect if it's fruit
    switch (typeBlock) {
      case TypeBlock.wolf:
        add(
          MoveEffect.by(
            Vector2(-.5 * size.x, 0),
            EffectController(
                duration: 2,
                alternate: true,
                infinite: true,
                onMax: () {
                  flipHorizontally();
                }),
          ),
        );
        break;
      case TypeBlock.seed:
        add(
          MoveEffect.by(
            Vector2(0, -.2 * size.x),
            EffectController(
              duration: 1,
              alternate: true,
              infinite: true,
            ),
          ),
        );
        break;
      case TypeBlock.waste:
      case TypeBlock.fruit:
        add(
          SizeEffect.by(
            Vector2.all(.2 * size.x),
            EffectController(
              duration: 2,
              alternate: true,
              infinite: true,
            ),
          ),
        );
      default:
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    switch (typeBlock) {
      case TypeBlock.enemyCO2:
      case TypeBlock.enemyRadioactive:
        if (other is GlowingBall) {
          live -= 1;
          AudioManager.instance.playSfx('enemy_hit.wav');

          if (live == 0) {
            add(RemoveEffect());
            game.playerData.nbEnemy += 1;
            game.playerData.currentScore += bonusScore;
            removeFromParent();
          }
        }
        break;
      case TypeBlock.bird:
      case TypeBlock.waste:
      case TypeBlock.wolf:
      case TypeBlock.seed:
      case TypeBlock.fruit:
      case TypeBlock.squirrel:
        if (other is Player) {
          game.playerData.currentScore += bonusScore;
          removeFromParent();
        }
        // add song effect
        break;
      case TypeBlock.arrowTree:
        if (other is Player && other.playerData.seed > 0) {
          game.playerData.currentScore += bonusScore;
          game.world.add(Tree(
              typeBlock: TypeBlock.tree,
              sizeElement: Vector2.all(42),
              positionSpawn: position));
          removeFromParent();
        }
        break;
      default:
        break;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
