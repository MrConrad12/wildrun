import 'package:flame/components.dart';

enum TypeBlock {
  wolf,
  bird,
  ground,
  platform,
  enemyCO2,
  enemyRadioactive,
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
  Block(Vector2(1, 1), TypeBlock.waste),
  Block(Vector2(5, 1), TypeBlock.enemyCO2),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(0, 4), TypeBlock.platform),
  Block(Vector2(5, 4), TypeBlock.platform),
  Block(Vector2(1, 1), TypeBlock.wolf),
  Block(Vector2(3, 4), TypeBlock.bird),
  Block(Vector2(7, 1), TypeBlock.waste),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 4), TypeBlock.platform),
  Block(Vector2(1, 1), TypeBlock.waste),
  Block(Vector2(7, 1), TypeBlock.enemyRadioactive),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(3, 3), TypeBlock.platform),
  Block(Vector2(4, 3), TypeBlock.platform),
  Block(Vector2(2, 3), TypeBlock.platform),
  Block(Vector2(3, 1), TypeBlock.wolf),
  Block(Vector2(0, 1), TypeBlock.fruit),
  Block(Vector2(1, 1), TypeBlock.waste),
  Block(Vector2(4, 1), TypeBlock.enemyCO2),
];
