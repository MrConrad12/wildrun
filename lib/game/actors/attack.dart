import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import '../objects/entity.dart';
import '/game/wildrun.dart';
import 'player.dart';

class GlowingBall extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<WildRun> {
  double ballSpeed = 120;
  double _distanceBall = 100;
  set distanceBall(value) {
    _distanceBall = value;
  }

  late double startPositionX;
  GlowingBall()
      : super(
          size: Vector2(16, 16),
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    Player infoPlayer = game.player;
    startPositionX = infoPlayer.x + infoPlayer.width;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('effects/attack.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .2,
        textureSize: Vector2(32, 32),
      ),
    );
    position = Vector2(
        infoPlayer.x + infoPlayer.width, infoPlayer.y - infoPlayer.height / 3);
    add(RectangleHitbox(collisionType: CollisionType.active));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += dt * ballSpeed;

    if (position.x > startPositionX + _distanceBall) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Entity) &&
        (other.typeBlock == TypeBlock.enemyCO2 ||
            other.typeBlock == TypeBlock.enemyRadioactive)) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
