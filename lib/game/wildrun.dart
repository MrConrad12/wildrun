import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import '/game/player.dart';
import '/widgets/hud.dart';
import '/models/settings.dart';
import '/game/audio_manager.dart';
import '/game/enemy_manager.dart';
import '/models/player_data.dart';
import '/widgets/pause_menu.dart';
import '/widgets/game_over_menu.dart';

class WildRun extends FlameGame with TapDetector, HasCollisionDetection {
  WildRun({super.camera});
  //images
  static const _imageAssets = [
    'players/player1/player.png',
    'parallax/plx-1.png',
    'parallax/plx-2.png',
    'parallax/plx-3.png',
    'parallax/plx-4.png',
    'parallax/plx-5.png',
    'parallax/plx-6.png',
    'parallax/plx-7.png',
    'parallax/plx-8.png',
    'enemies/enemy.png',
    'animals/squirel.png',
    'animals/wolf.png',
  ];

  //audio
  static const _audioAssets = [
    '8BitPlatformerLoop.wav',
    'hurt7.wav',
    'jump14.wav',
  ];

  late Player _player;
  late Settings settings;
  late PlayerData playerData;
  late EnemyManager _enemyManager;

  Vector2 get virtualSize => camera.viewport.virtualSize;

  @override
  Future<void> onLoad() async {
    // Makes the game full screen and landscape only.
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    playerData = await _readPlayerData();
    settings = await _readSettings();

    await AudioManager.instance.init(_audioAssets, settings);
    AudioManager.instance.startBgm('8BitPlatformerLoop.wav');
    await images.loadAll(_imageAssets);

    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    /// Create a [ParallaxComponent] and add it to game.
    final parallaxBackground = await loadParallaxComponent([
      ParallaxImageData('parallax/plx-1.png'),
      ParallaxImageData('parallax/plx-2.png'),
      ParallaxImageData('parallax/plx-3.png'),
      ParallaxImageData('parallax/plx-4.png'),
      ParallaxImageData('parallax/plx-5.png'),
      ParallaxImageData('parallax/plx-6.png'),
      ParallaxImageData('parallax/plx-7.png'),
      ParallaxImageData('parallax/plx-8.png'),
    ], baseVelocity: Vector2(10, 0), velocityMultiplierDelta: Vector2(1.4, 0));
    camera.backdrop.add(parallaxBackground);
  }

  void startGamePlay() {
    _player =
        Player(images.fromCache('players/player1/player.png'), playerData);
    _enemyManager = EnemyManager();

    world.add(_player);
    world.add(_enemyManager);
  }

  void _disconnectActors() {
    _player.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  void reset() {
    _disconnectActors();
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  @override
  void update(double dt) {
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(Hud.id)) {
      _player.jump();
    }
    super.onTapDown(info);
  }

  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('WildRun.PlayerDataBox');
    final playerData = playerDataBox.get('WildRun.PlayerData');

    if (playerData == null) {
      await playerDataBox.put('WildRun.PlayerData', PlayerData());
    }
    return playerDataBox.get('WildRun.PlayerData')!;
  }

  Future<Settings> _readSettings() async {
    final settingsBox = await Hive.openBox<Settings>('WildRun.SettingsBox');
    final settings = settingsBox.get('WildRun.Settings');

    if (settings == null) {
      await settingsBox.put(
        'WildRun.Settings',
        Settings(bgm: true, sfx: true),
      );
    }
    return settingsBox.get('WildRun.Settings')!;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(overlays.isActive(PauseMenu.id)) &&
            !(overlays.isActive(GameOverMenu.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        // If game is active, then remove Hud and add PauseMenu
        // before pausing the game.
        if (overlays.isActive(Hud.id)) {
          overlays.remove(Hud.id);
          overlays.add(PauseMenu.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
