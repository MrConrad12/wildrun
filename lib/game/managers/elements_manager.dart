import 'package:flame/components.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/animal.dart';
import '../objects/enemy.dart';
import '../wildrun.dart';

class Element {
  final Vector2 gridPosition;
  final Type blockType;
  Element(this.gridPosition, this.blockType);
}

final segments = [segment0, segment3, segment1, segment2];
final segment0 = [
  for (double i = 0; i <= 9; i++) Element(Vector2(i, 0), GroundBlock),
];

final segment1 = [
  for (double i = 0; i <= 9; i++) Element(Vector2(i, 0), GroundBlock),
  Element(Vector2(0, 4), PlatformBlock),
  Element(Vector2(0, 4), PlatformBlock),
  Element(Vector2(5, 4), PlatformBlock),
  Element(Vector2(1, 1), Animal),
];

final segment2 = [
  for (double i = 0; i <= 9; i++) Element(Vector2(i, 0), GroundBlock),
  Element(Vector2(0, 4), PlatformBlock),
  Element(Vector2(5, 4), PlatformBlock),
  Element(Vector2(1, 1), Animal),
];

final segment3 = [
  for (double i = 0; i <= 9; i++) Element(Vector2(i, 0), GroundBlock),
  Element(Vector2(3, 3), PlatformBlock),
  Element(Vector2(4, 3), PlatformBlock),
  Element(Vector2(5, 3), PlatformBlock),
  Element(Vector2(3, 1), Animal),
];

class ElementManager extends Component with HasGameReference<WildRun> {
  WildRun gameRef;
  late int segmentsToLoad;

  ElementManager({required this.gameRef});

  void initializeElements() {
    segmentsToLoad = (gameRef.size.x / 320).ceil();
    segmentsToLoad.clamp(0, segments.length);
    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameRefSegments(i, (320 * i - 2).toDouble());
    }
  }

  void loadGameRefSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case const (GroundBlock):
          gameRef.world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case const (PlatformBlock):
          gameRef.world.add(PlatformBlock(
              gridPosition: block.gridPosition, xOffset: xPositionOffset));
          break;
        case const (Enemy):
          gameRef.world.add(PlatformBlock(
              gridPosition: block.gridPosition, xOffset: xPositionOffset));
          break;
        case const (Animal):
          gameRef.world.add(
            Animal(gridPosition: block.gridPosition, xOffset: xPositionOffset),
          );
          break;
        default:
          break;
      }
    }
  }

  void removeAllElements() {
    List allElements = [
      ...gameRef.world.children.whereType<Animal>(),
      ...gameRef.world.children.whereType<Enemy>(),
      ...gameRef.world.children.whereType<GroundBlock>(),
      ...gameRef.world.children.whereType<PlatformBlock>(),
    ];
    for (var element in allElements) {
      element.removeFromParent();
    }
  }
}
