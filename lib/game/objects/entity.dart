import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import 'package:flame/effects.dart';
import '../wildrun.dart';

class Entity extends SpriteAnimationComponent with HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final String urlImg;
  late Vector2 gridPosition;
  late double xOffset;
  final Vector2 velocity = Vector2.zero();
  final Vector2 sizeElement;
  final Vector2 spriteSize;
  final int nbFrame;
  final double spriteTime;

  Entity({
    required this.typeBlock,
    required this.urlImg,
    required this.sizeElement,
    required this.spriteSize,
    required this.nbFrame,
    required this.spriteTime,
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: sizeElement, anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(urlImg),
      SpriteAnimationData.sequenced(
        amount: nbFrame,
        textureSize: spriteSize,
        stepTime: spriteTime,
      ),
    );
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y * 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    flipHorizontally();

    if (typeBlock == TypeBlock.fruit) {
      add(
        MoveEffect.by(
          Vector2(-.5 * size.x, 0),
          EffectController(
            duration: 2,
            alternate: true,
            infinite: true,
          ),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
