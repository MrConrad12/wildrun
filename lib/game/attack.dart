import 'package:flame/components.dart';
import '/game/wildrun.dart';

class GlowingBall extends SpriteAnimationComponent
    with HasGameReference<WildRun> {
  double ballSpeed = 2;

  GlowingBall({
    super.position,
  }) : super(
          size: Vector2(25, 50), // size of the ball
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      '/effects/glowingball.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: .2,
        textureSize: Vector2(252, 222),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= dt * ballSpeed;
    if (position.x > width) {
      removeFromParent();
    }
  }
}
