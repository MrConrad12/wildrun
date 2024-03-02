import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import '../wildrun.dart';

class Decoration extends SpriteComponent with HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final String urlImg;
  late Vector2 gridPosition;
  late double xOffset;
  final Vector2 velocity = Vector2.zero();
  final Vector2 sizeElement;
  get posY => position.y;
  get posX => position.x;

  Decoration({
    required this.typeBlock,
    required this.urlImg,
    required this.gridPosition,
    required this.xOffset,
    required this.sizeElement,
  }) : super(size: sizeElement, anchor: Anchor.center);

  @override
  void onLoad() {
    const double sizeBox = 32;
    final platformImage = game.images.fromCache(urlImg);
    sprite = Sprite(platformImage);

    position = Vector2(
      (gridPosition.x * sizeBox) + xOffset,
      game.size.y - (gridPosition.y * sizeBox),
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
