import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/mapping.dart';
import '../objects/entity.dart';
import '/game/wildrun.dart';
import 'player.dart';

class GlowingBall extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<WildRun> {
  double ballSpeed = 100;
  GlowingBall()
      : super(
          size: Vector2(12, 14),
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    Player infoPlayer = game.player;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('effects/glowingball.png'),
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: .2,
        textureSize: Vector2(192, 205),
      ),
    );
    position = Vector2(
        infoPlayer.x + infoPlayer.width, infoPlayer.y - infoPlayer.height / 3);
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is Entity) && (other.typeBlock == TypeBlock.wolf)) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += dt * ballSpeed;
    if (position.x > game.sizeScreen.width) {
      removeFromParent();
    }
  }
}
