import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import 'actors/player.dart';
import '/widgets/hud.dart';
import '/models/settings.dart';
import 'managers/audio_manager.dart';
import 'managers/elements_manager.dart';
import '/models/player_data.dart';
import '/widgets/pause_menu.dart';
import '/widgets/game_over_menu.dart';

// Game class representing the main game logic
class WildRun extends FlameGame
    with TapDetector, HasCollisionDetection, HasGameReference<WildRun> {
  Size sizeScreen;
  WildRun({super.camera, required this.sizeScreen});

  // Asset paths for images
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
    'animals/bird.png',
    'animals/hog.png',
    'animals/wolf.png',
    'landscape/ground.png',
    'landscape/void.png',
    'landscape/platform_center.png',
  ];
  // Asset paths for audio files
  static const _audioAssets = [
    '8BitPlatformerLoop.wav',
    'hurt7.wav',
    'jump14.wav',
  ];

  double objectSpeed = 100;
  late Player _player;
  late Settings settings;
  late PlayerData playerData;
  late ElementManager _elementManager;
  get elementManager => _elementManager;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  Vector2 get virtualSize => camera.viewport.virtualSize;

  // Method called when the game is loaded
  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    playerData = await _readPlayerData();
    settings = await _readSettings();

    await AudioManager.instance.init(_audioAssets, settings);
    AudioManager.instance.startBgm('8BitPlatformerLoop.wav');
    await images.loadAll(_imageAssets);
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    // Load parallax background images
    final parallaxBackground = await loadParallaxComponent(
        [for (var i = 1; i <= 8; i++) ParallaxImageData('parallax/plx-$i.png')],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta: Vector2(1.38, 0));
    camera.backdrop.add(parallaxBackground);
  }

  // Method to start the gameplay
  void startGamePlay() {
    _elementManager = ElementManager(gameRef: game);
    _elementManager.initializeElements();

    _player =
        Player(images.fromCache('players/player1/player.png'), playerData);

    world.add(_player);
    world.add(_elementManager);
  }

  // Method to disconnect actors and reset game state
  void _disconnectActors() {
    _player.removeFromParent();
    _elementManager.removeAllElements();
    _elementManager.removeFromParent();
  }

  // Method to reset the game
  void reset() {
    _disconnectActors();
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  // Method called on every game update
  @override
  void update(double dt) {
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }
    game.playerData.currentScore += ((objectSpeed * dt)).toInt();
    super.update(dt);
  }

  // Method called when a tap event occurs
  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(Hud.id)) {
      if (info.eventPosition.widget.x >= (sizeScreen.width / 2)) {
        _player.jump();
      }
      if (info.eventPosition.widget.x < (sizeScreen.width / 2)) {
        _player.attack();
      }
    }
    super.onTapDown(info);
  }

  // Method to read player data from local storage
  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('WildRun.PlayerDataBox');
    final playerData = playerDataBox.get('WildRun.PlayerData');

    if (playerData == null) {
      await playerDataBox.put('WildRun.PlayerData', PlayerData());
    }
    return playerDataBox.get('WildRun.PlayerData')!;
  }

  // Method to read settings from local storage
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

  // Method to handle lifecycle state changes of the application
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
