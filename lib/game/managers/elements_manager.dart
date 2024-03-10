import 'package:flame/components.dart';
import 'package:wildrun/game/objects/tree.dart';

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
    gameRef.lastBlockXPosition = 0.0;

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
        case TypeBlock.spiked:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.spiked,
                urlImg: 'landscape/spiked.png',
                sizeElement: Vector2(32, 20),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(36, 9),
                spriteTime: 1,
                nbFrame: 1,
                bonusScore: 0),
          );
          break;
        case TypeBlock.arrowTree:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.arrowTree,
                urlImg: 'items/arrowTree.png',
                sizeElement: Vector2(16, 16),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(18, 18),
                spriteTime: .1,
                nbFrame: 10,
                bonusScore: 0),
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
                nbFrame: 4,
                bonusScore: 30),
          );
          break;
        case TypeBlock.squirrel:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.squirrel,
                urlImg: 'animals/squirel.png',
                sizeElement: Vector2.all(20),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2.all(32),
                spriteTime: .5,
                nbFrame: 6,
                bonusScore: 40),
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
                nbFrame: 4,
                bonusScore: 50),
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
                nbFrame: 17,
                bonusScore: 10),
          );
          break;
        case TypeBlock.waste:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.waste,
                urlImg: 'landscape/waste.png',
                sizeElement: Vector2(26, 20),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(64, 54),
                spriteTime: .2,
                nbFrame: 1,
                bonusScore: 75),
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
                nbFrame: 10,
                bonusScore: 80),
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
                nbFrame: 10,
                bonusScore: 80),
          );
          break;
        case TypeBlock.seed:
          gameRef.world.add(
            Entity(
                typeBlock: TypeBlock.seed,
                urlImg: 'items/seed.png',
                sizeElement: Vector2(28, 28),
                gridPosition: block.gridPosition,
                xOffset: xPositionOffset,
                spriteSize: Vector2(500, 500),
                spriteTime: .2,
                nbFrame: 1,
                bonusScore: 100),
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
      ...gameRef.world.children.whereType<GroundBlock>(),
      ...gameRef.world.children.whereType<Tree>(),
    ];
    for (var element in allElements) {
      element.removeFromParent();
    }
  }
}
