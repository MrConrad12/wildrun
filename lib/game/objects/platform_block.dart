import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../wildrun.dart';

class PlatformBlock extends SpriteComponent with HasGameReference<WildRun> {
  final Vector2 velocity = Vector2.zero();
  final Vector2 gridPosition;
  double xOffset;
  get posY => position.y;
  get posX => position.x;

  PlatformBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2(30, 16), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final platformImage =
        game.images.fromCache('landscape/platform_center.png');
    sprite = Sprite(platformImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
