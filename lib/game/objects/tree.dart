import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import '../wildrun.dart';

class Tree extends SpriteComponent with HasGameReference<WildRun> {
  final TypeBlock typeBlock;
  final Vector2 positionSpawn;
  final Vector2 sizeElement;
  final Vector2 velocity = Vector2.zero();

  Tree({
    required this.typeBlock,
    required this.positionSpawn,
    required this.sizeElement,
  }) : super(size: sizeElement, anchor: Anchor.center);

  @override
  void onLoad() {
    int positionTree = Random().nextInt(4);
    final treeImg = game.images.fromCache("landscape/tree$positionTree.png");
    sprite = Sprite(treeImg);
    position = Vector2(positionSpawn.x, positionSpawn.y - 12);
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
