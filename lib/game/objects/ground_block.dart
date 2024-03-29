import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../managers/mapping.dart';
import '../wildrun.dart';

class GroundBlock extends SpriteComponent with HasGameReference<WildRun> {
  final Vector2 gridPosition;
  double xOffset;
  String urlImage;

  final UniqueKey _blockKey = UniqueKey();
  final Vector2 velocity = Vector2.zero();

  GroundBlock({
    required this.gridPosition,
    required this.xOffset,
    this.urlImage = 'landscape/void.png',
  }) : super(size: Vector2.all(32), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final groundImage = game.images.fromCache(urlImage);
    sprite = Sprite(groundImage);

    position = Vector2(
      gridPosition.x * size.x + xOffset,
      game.size.y - gridPosition.y * size.y,
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    if (gridPosition.x == 9 && position.x > game.lastBlockXPosition) {
      game.lastBlockKey = _blockKey;
      game.lastBlockXPosition = position.x;
    }
  }

  @override
  void update(double dt) {
    velocity.x = -game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) {
      removeFromParent();
      if (gridPosition.x == 0) {
        game.elementManager.loadGameRefSegments(
          Random().nextInt(segments.length),
          game.lastBlockXPosition,
        );
      }
    }
    if (game.lastBlockKey == _blockKey && gridPosition.x == 9) {
      game.lastBlockXPosition = position.x + size.x - 10;
    }
    super.update(dt);
  }
}
