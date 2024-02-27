import 'package:flame/components.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/animals.dart';

final segments = [segment0, segment3, segment1, segment2];
final segment0 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), GroundBlock),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), GroundBlock),
  Block(Vector2(0, 4), PlatformBlock),
  Block(Vector2(0, 4), PlatformBlock),
  Block(Vector2(5, 4), PlatformBlock),
  Block(Vector2(1, 1), Animal),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), GroundBlock),
  Block(Vector2(0, 4), PlatformBlock),
  Block(Vector2(5, 4), PlatformBlock),
  Block(Vector2(1, 1), Animal),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Block(Vector2(i, 0), GroundBlock),
  Block(Vector2(3, 3), PlatformBlock),
  Block(Vector2(4, 3), PlatformBlock),
  Block(Vector2(5, 3), PlatformBlock),
  Block(Vector2(3, 1), Animal),
];

class Block {
  final Vector2 gridPosition;
  final Type blockType;
  Block(this.gridPosition, this.blockType);
}
