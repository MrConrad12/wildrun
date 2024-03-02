import 'package:flame/components.dart';

import '../objects/entity.dart';
import '../objects/decoration.dart';
import '../objects/ground_block.dart';
import '../wildrun.dart';
import 'mapping.dart';

class ElementManager extends Component with HasGameReference<WildRun> {
  WildRun gameRef;
  late int segmentsToLoad;

  ElementManager({required this.gameRef});

  void initializeElements() {
    segmentsToLoad = (gameRef.size.x / 320).ceil();
    segmentsToLoad.clamp(0, segments.length);
    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameRefSegments(i, (320 * i).toDouble());
    }
  }

  void loadGameRefSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case TypeBlock.ground:
          gameRef.world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case TypeBlock.platform:
          gameRef.world.add(
            Decoration(
              typeBlock: TypeBlock.platform,
              urlImg: 'landscape/platform_center.png',
              sizeElement: Vector2(32, 12),
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case TypeBlock.wolf:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.wolf,
                urlImg: 'animals/wolf.png',
                sizeElement: Vector2.all(16),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2.all(16),
                spriteTime: .5,
                nbFrame: 4),
          );
          break;
        case TypeBlock.bird:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.bird,
                urlImg: 'animals/bird.png',
                sizeElement: Vector2.all(16),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2.all(16),
                spriteTime: .2,
                nbFrame: 4),
          );
          break;
        case TypeBlock.fruit:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.fruit,
                urlImg: 'items/Apple.png',
                sizeElement: Vector2.all(18),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2.all(32),
                spriteTime: .2,
                nbFrame: 17),
          );
          break;
        case TypeBlock.waste:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.waste,
                urlImg: 'landscape/waste.png',
                sizeElement: Vector2(30, 24),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(64, 54),
                spriteTime: .2,
                nbFrame: 1),
          );
          break;
        case TypeBlock.enemyCO2:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.enemyCO2,
                urlImg: 'enemies/CO2.png',
                sizeElement: Vector2(32, 21),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(44, 30),
                spriteTime: .2,
                nbFrame: 10),
          );
          break;
        case TypeBlock.enemyRadioactive:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.enemyRadioactive,
                urlImg: 'enemies/radioactivity.png',
                sizeElement: Vector2(32, 21),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(44, 30),
                spriteTime: .2,
                nbFrame: 10),
          );
          break;
        default:
          break;
      }
    }
  }

  void removeAllElements() {
    List allElements = [
      ...gameRef.world.children.whereType<Entity>(),
      ...gameRef.world.children.whereType<Decoration>(),
    ];
    for (var element in allElements) {
      element.removeFromParent();
    }
  }
}
