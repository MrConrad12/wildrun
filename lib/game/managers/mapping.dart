import 'package:flame/components.dart';

enum TypeBlock {
  wolf,
  bird,
  ground,
  platform,
  seed,
  spiked,
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

final segments = [
  segment0,
  segment1,
  segment2,
  segment3,
  segment4,
  segment5,
  segment6,
  segment7
];
final segment0 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 2), TypeBlock.platform),
  Block(Vector2(5, 1), TypeBlock.spiked),
  Block(Vector2(7, 1), TypeBlock.fruit),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.enemyCO2),
  Block(Vector2(4, 1), TypeBlock.waste),
  Block(Vector2(6, 1), TypeBlock.enemyRadioactive),
  Block(Vector2(8, 1), TypeBlock.waste),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(3, 3), TypeBlock.bird),
  Block(Vector2(3, 1), TypeBlock.spiked),
  Block(Vector2(4, 1), TypeBlock.spiked),
  Block(Vector2(5, 1), TypeBlock.spiked),
  Block(Vector2(6, 1), TypeBlock.spiked),
  Block(Vector2(7, 1), TypeBlock.spiked),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(4, 3), TypeBlock.bird),
  Block(Vector2(6, 3), TypeBlock.seed),
  Block(Vector2(7, 3), TypeBlock.seed),
  Block(Vector2(8, 3), TypeBlock.seed),
  Block(Vector2(6, 1), TypeBlock.spiked),
  Block(Vector2(7, 1), TypeBlock.spiked),
  Block(Vector2(8, 1), TypeBlock.spiked),
];

final segment4 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 2), TypeBlock.platform),
  Block(Vector2(4, 3), TypeBlock.platform),
  Block(Vector2(6, 4), TypeBlock.bird),
  Block(Vector2(8, 4), TypeBlock.fruit),
];

final segment5 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(6, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.seed),
  Block(Vector2(5, 1), TypeBlock.enemyRadioactive),
];

final segment6 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(6, 2), TypeBlock.platform),
  Block(Vector2(4, 2), TypeBlock.spiked),
  Block(Vector2(5, 2), TypeBlock.spiked),
  Block(Vector2(6, 2), TypeBlock.spiked),
  Block(Vector2(5, 1), TypeBlock.enemyCO2),
  Block(Vector2(2, 3), TypeBlock.bird),
];

final segment7 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.waste),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(6, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.enemyCO2),
  Block(Vector2(5, 1), TypeBlock.enemyRadioactive),
];
