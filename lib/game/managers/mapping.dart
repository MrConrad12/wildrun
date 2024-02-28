import 'package:flame/components.dart';

enum TypeBlock {
  wolf,
  bird,
  ground,
  platform,
  enemy,
  waste,
  fruit,
}

class Block {
  final Vector2 gridPosition;
  final TypeBlock blockType;
  Block(this.gridPosition, this.blockType);
}

final segments = [segment0, segment3, segment1, segment2];
final segment0 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(3, 3), TypeBlock.bird),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(0, 4), TypeBlock.platform),
  Block(Vector2(0, 4), TypeBlock.platform),
  Block(Vector2(5, 4), TypeBlock.platform),
  Block(Vector2(1, 1), TypeBlock.wolf),
  Block(Vector2(3, 4), TypeBlock.bird),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(0, 4), TypeBlock.platform),
  Block(Vector2(5, 4), TypeBlock.platform),
  Block(Vector2(1, 1), TypeBlock.wolf),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(3, 3), TypeBlock.platform),
  Block(Vector2(4, 3), TypeBlock.platform),
  Block(Vector2(5, 3), TypeBlock.platform),
  Block(Vector2(3, 1), TypeBlock.wolf),
  Block(Vector2(4, 2), TypeBlock.bird),
];
