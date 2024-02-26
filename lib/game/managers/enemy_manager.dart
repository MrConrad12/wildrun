import 'dart:math';

import 'package:flame/components.dart';

import '../actors/enemy.dart';
import '/game/wildrun.dart';
import '/models/enemy_data.dart';

//spawning random enemies
class EnemyManager extends Component with HasGameReference<WildRun> {
  final List<EnemyData> _data = [];
  //generator enemies
  final Random _random = Random();
  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  void spawnRandomEnemy() {
    // randomly generate index
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    // set enemies on ground
    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      game.virtualSize.x + 32,
      game.virtualSize.y - 24,
    );

    // set enemies which can fly
    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.size = enemyData.textureSize;
    game.world.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }
    if (_data.isEmpty) {
      _data.addAll([
        EnemyData(
            image: game.images.fromCache('enemies/enemy.png'),
            nFrames: 2,
            stepTime: .5,
            textureSize: Vector2(24, 17),
            speedX: 80,
            canFly: false),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
