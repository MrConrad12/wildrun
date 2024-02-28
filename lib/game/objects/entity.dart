import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import 'package:flame/effects.dart';
import '../wildrun.dart';

class Entity extends SpriteAnimationComponent with HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final String urlImg;
  late Vector2 _gridPosition;
  late double _xOffset;
  final Vector2 velocity = Vector2.zero();
  final Vector2 sizeElement;
  final Vector2 spriteSize;
  final int nbFrame;

  Entity({
    required this.typeBlock,
    required this.urlImg,
    required this.sizeElement,
    required this.spriteSize,
    required this.nbFrame,
  }) : super(size: sizeElement, anchor: Anchor.center);

  void setPos(Vector2 gridPosition, double xOffset) {
    print('hey');
    _gridPosition = gridPosition;
    _xOffset = xOffset;
  }

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(urlImg),
      SpriteAnimationData.sequenced(
        amount: nbFrame,
        textureSize: spriteSize,
        stepTime: 0.70,
      ),
    );
    position = Vector2(
      (_gridPosition.x * size.x) + _xOffset,
      game.size.y - (_gridPosition.y * size.y * 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));

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
    debugMode = true;

    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
