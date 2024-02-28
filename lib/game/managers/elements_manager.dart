import 'package:flame/components.dart';
import 'package:wildrun/game/objects/entity.dart';
import '../../models/element_data.dart';
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
      loadGameRefSegments(i, (320 * i - 2).toDouble());
    }
  }

  void loadGameRefSegments(int segmentIndex, double xPositionOffset) {
    dynamic element;
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
          element = listElement[TypeBlock.platform];
          element?.setPos(block.gridPosition, xPositionOffset);
          gameRef.world.add(element!);
          print("rere");
          break;
        case TypeBlock.enemy:
          element = listElement[TypeBlock.enemy];
          element?.setPos(block.gridPosition, xPositionOffset);
          gameRef.world.add(element!);
          break;
        case TypeBlock.animal:
          element = listElement[TypeBlock.animal];
          element?.setPos(block.gridPosition, xPositionOffset);
          gameRef.world.add(element!);
          break;
        case TypeBlock.coin:
          element = listElement[TypeBlock.coin];
          element?.setPos(block.gridPosition, xPositionOffset);
          gameRef.world.add(element!);
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
