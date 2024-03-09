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
  arrowTree,
  tree,
  squirrel,
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
  segment7,
  segment8,
  segment9,
  segment10,
  segment11,
  segment12,
  segment13,
  segment14,
  segment15,
];
final segment0 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(6, 2), TypeBlock.platform),
  Block(Vector2(7, 2), TypeBlock.platform),
  Block(Vector2(8, 2), TypeBlock.platform),
  Block(Vector2(7, 1), TypeBlock.spiked),
  Block(Vector2(7, 2), TypeBlock.seed),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.seed),
  Block(Vector2(4, 1), TypeBlock.waste),
  Block(Vector2(6, 1), TypeBlock.enemyRadioactive),
  Block(Vector2(8, 1), TypeBlock.waste),
  Block(Vector2(9, 1), TypeBlock.arrowTree),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 3), TypeBlock.bird),
  Block(Vector2(5, 3), TypeBlock.fruit),
  Block(Vector2(3, 1), TypeBlock.spiked),
  Block(Vector2(4, 1), TypeBlock.spiked),
  Block(Vector2(5, 1), TypeBlock.spiked),
  Block(Vector2(6, 1), TypeBlock.spiked),
  Block(Vector2(7, 1), TypeBlock.spiked),
  Block(Vector2(9, 1), TypeBlock.enemyCO2),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(4, 3), TypeBlock.bird),
  Block(Vector2(7, 3), TypeBlock.seed),
  Block(Vector2(6, 1), TypeBlock.spiked),
  Block(Vector2(7, 1), TypeBlock.spiked),
  Block(Vector2(8, 1), TypeBlock.spiked),
  Block(Vector2(1, 1), TypeBlock.arrowTree),
];

final segment4 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 2), TypeBlock.platform),
  Block(Vector2(4, 3), TypeBlock.platform),
  Block(Vector2(6, 4), TypeBlock.bird),
  Block(Vector2(8, 4), TypeBlock.fruit),
  Block(Vector2(1, 1), TypeBlock.arrowTree),
];

final segment5 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(6, 2), TypeBlock.platform),
  Block(Vector2(5, 1), TypeBlock.enemyRadioactive),
  Block(Vector2(1, 1), TypeBlock.arrowTree),
];

final segment6 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.wolf),
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

final segment8 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.wolf),
  Block(Vector2(4, 1), TypeBlock.spiked),
  Block(Vector2(5, 1), TypeBlock.spiked),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(8, 3), TypeBlock.fruit),
  Block(Vector2(7, 1), TypeBlock.enemyRadioactive),
];

final segment9 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.fruit),
  Block(Vector2(4, 2), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.squirrel),
  Block(Vector2(9, 3), TypeBlock.seed),
];

final segment10 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(1, 1), TypeBlock.waste),
  Block(Vector2(3, 2), TypeBlock.platform),
  Block(Vector2(5, 3), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.platform),
  Block(Vector2(7, 3), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.enemyCO2),
  Block(Vector2(8, 1), TypeBlock.arrowTree),
];

final segment11 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(1, 1), TypeBlock.waste),
  Block(Vector2(3, 2), TypeBlock.platform),
  Block(Vector2(3, 2), TypeBlock.squirrel),
  Block(Vector2(5, 1), TypeBlock.enemyRadioactive),
  Block(Vector2(7, 1), TypeBlock.spiked),
  Block(Vector2(8, 1), TypeBlock.spiked),
];

final segment12 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(1, 1), TypeBlock.enemyCO2),
  Block(Vector2(3, 2), TypeBlock.platform),
  Block(Vector2(4, 1), TypeBlock.spiked),
  Block(Vector2(5, 1), TypeBlock.arrowTree),
  Block(Vector2(6, 1), TypeBlock.spiked),
  Block(Vector2(7, 2), TypeBlock.platform),
  Block(Vector2(9, 1), TypeBlock.waste),
];

final segment13 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(1, 1), TypeBlock.spiked),
  Block(Vector2(1, 2), TypeBlock.fruit),
  Block(Vector2(4, 1), TypeBlock.squirrel),
  Block(Vector2(5, 2), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.bird),
  Block(Vector2(7, 1), TypeBlock.enemyRadioactive),
];

final segment14 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(3, 1), TypeBlock.spiked),
  Block(Vector2(3, 2), TypeBlock.platform),
  Block(Vector2(6, 3), TypeBlock.platform),
  Block(Vector2(7, 3), TypeBlock.platform),
  Block(Vector2(8, 3), TypeBlock.platform),
  Block(Vector2(7, 1), TypeBlock.seed),
  Block(Vector2(7, 3), TypeBlock.fruit),
  Block(Vector2(8, 1), TypeBlock.spiked),
  Block(Vector2(9, 1), TypeBlock.spiked),
];

final segment15 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), TypeBlock.ground),
  Block(Vector2(2, 1), TypeBlock.waste),
  Block(Vector2(4, 1), TypeBlock.enemyCO2),
  Block(Vector2(6, 1), TypeBlock.arrowTree),
  Block(Vector2(8, 2), TypeBlock.platform),
  Block(Vector2(9, 2), TypeBlock.fruit),
];
