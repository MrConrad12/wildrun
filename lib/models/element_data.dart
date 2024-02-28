import 'package:flame/components.dart';
import 'package:wildrun/game/objects/entity.dart';
import 'package:wildrun/game/objects/decoration.dart';
import '../game/managers/mapping.dart';

Map<TypeBlock, dynamic> listElement = {
  TypeBlock.animal: Entity(
    typeBlock: TypeBlock.animal,
    urlImg: 'animals/wolf.png',
    spriteSize: Vector2.all(16),
    nbFrame: 4,
    sizeElement: Vector2.all(14),
  ),
  TypeBlock.enemy: Entity(
    typeBlock: TypeBlock.enemy,
    urlImg: 'animals/wolf.png',
    spriteSize: Vector2.all(16),
    nbFrame: 4,
    sizeElement: Vector2.all(14),
  ),
  TypeBlock.coin: Entity(
    typeBlock: TypeBlock.coin,
    urlImg: 'animals/wolf.png',
    spriteSize: Vector2.all(16),
    nbFrame: 4,
    sizeElement: Vector2.all(14),
  ),
  TypeBlock.platform: Decoration(
    typeBlock: TypeBlock.platform,
    urlImg: 'landscape/platform_center.png',
    sizeElement: Vector2(30, 16),
  ),
  TypeBlock.waste: Decoration(
    typeBlock: TypeBlock.waste,
    urlImg: 'animals/wolf.png',
    sizeElement: Vector2.all(14),
  ),
};
