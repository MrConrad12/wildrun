import 'package:flame/components.dart';

export 'player.dart';

// Enum for Player's animation states
enum PlayerAnimationStates {
  idle,
  walk,
  run,
  hit,
  attack,
  death,
  jump,
  fly,
}

// Static map for storing animation data
final animationMap = {
  PlayerAnimationStates.idle: SpriteAnimationData.sequenced(
    amount: 2,
    stepTime: 0.1,
    textureSize: Vector2.all(32),
  ),
  PlayerAnimationStates.walk: SpriteAnimationData.sequenced(
    amount: 4,
    stepTime: 0.1,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(0, (2) * 32),
  ),
  PlayerAnimationStates.run: SpriteAnimationData.sequenced(
    amount: 8,
    stepTime: 0.05,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(0, (3) * 32),
  ),
  PlayerAnimationStates.hit: SpriteAnimationData.sequenced(
    amount: 1,
    stepTime: 0.05,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(32, (6) * 32),
  ),
  PlayerAnimationStates.attack: SpriteAnimationData.sequenced(
    amount: 8,
    stepTime: 0.1,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(0, (8) * 32),
  ),
  PlayerAnimationStates.death: SpriteAnimationData.sequenced(
    amount: 8,
    stepTime: 0.5,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(0, (7) * 32),
  ),
  PlayerAnimationStates.jump: SpriteAnimationData.sequenced(
    amount: 8,
    stepTime: 0.5,
    textureSize: Vector2.all(32),
    texturePosition: Vector2(0, (5) * 32),
  ),
  PlayerAnimationStates.fly: SpriteAnimationData.sequenced(
    amount: 4,
    stepTime: 0.1,
    textureSize: Vector2.all(32),
    texturePosition: Vector2((2) * 32, (5) * 32),
  ),
};
