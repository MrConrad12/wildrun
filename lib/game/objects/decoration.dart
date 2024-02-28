import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import '../wildrun.dart';

class Decoration extends SpriteComponent with HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final String urlImg;
  late Vector2 _gridPosition;
  late double _xOffset;
  final Vector2 velocity = Vector2.zero();
  final Vector2 sizeElement;

  Decoration({
    required this.typeBlock,
    required this.urlImg,
    required this.sizeElement,
  }) : super(size: sizeElement, anchor: Anchor.center);

  void setPos(Vector2 gridPosition, double xOffset) {
    _gridPosition = gridPosition;
    _xOffset = xOffset;
  }

  @override
  void onLoad() {
    debugMode = true;
    final platformImage =
        game.images.fromCache('landscape/platform_center.png');
    sprite = Sprite(platformImage);
    position = Vector2(
      (_gridPosition.x * size.x) + _xOffset,
      game.size.y - (_gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
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
