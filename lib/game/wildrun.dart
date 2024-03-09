import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:wildrun/game/managers/task_manager.dart';
import 'package:wildrun/models/task_data.dart';

//import '../models/card_data.dart';
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
    with
        TapDetector,
        HasCollisionDetection,
        KeyboardEvents,
        HasGameReference<WildRun> {
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
    'enemies/CO2.png',
    'enemies/radioactivity.png',
    'items/Apple.png',
    'items/seed.png',
    'items/arrowTree.png',
    'animals/bird.png',
    'animals/squirel.png',
    'animals/wolf.png',
    'effects/attack.png',
    'landscape/tree0.png',
    'landscape/tree1.png',
    'landscape/tree2.png',
    'landscape/tree3.png',
    'landscape/waste.png',
    'landscape/ground.png',
    'landscape/void.png',
    'landscape/spiked.png',
    'landscape/platform_center.png',
    'tutos/attack.png',
    'tutos/double_jump.png',
    'tutos/end.png',
    'tutos/enemies.png',
    'tutos/waste.png',
    'tutos/fly.png',
    'tutos/fruit.png',
    'tutos/jump.png',
    'tutos/plant_tree.png',
    'tutos/play.png',
    'tutos/squirrel.png',
    'tutos/wolf.png',
  ];
  // Asset paths for audio files
  static const _audioAssets = [
    '8BitPlatformerLoop.wav',
    'hurt7.wav',
    'jump14.wav',
    'animal.wav',
    'gameBgm.wav',
    'homeBgm',
    'seed.wav',
    'Selection.wav',
    'waste.wav',
  ];

  double objectSpeed = 110;
  late Player _player;
  late Settings settings;
  late PlayerData playerData;
  late TaskData taskData;
  late ElementManager _elementManager;
  double timer = .0;
  get elementManager => _elementManager;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  bool _actorInitialized = false;
  get actorInitialized => _actorInitialized;
  Player get player => _player;
  Vector2 get virtualSize => camera.viewport.virtualSize;

  // Method called when the game is loaded
  @override
  Future<void> onLoad() async {
    // configure device size and orientation
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    // load data
    playerData = await _readPlayerData();
    settings = await _readSettings();
    //cardData = await _readCardData();
    taskData = await _readTaskData();

    // load song
    await AudioManager.instance.init(_audioAssets, settings);
    AudioManager.instance.startBgm('homeBgm.wav');

    // load images and configure camera
    await images.loadAll(_imageAssets);
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    // Load parallax background images
    final parallaxBackground = await loadParallaxComponent(
        [for (var i = 1; i <= 8; i++) ParallaxImageData('parallax/plx-$i.png')],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta:
            Vector2(pow(objectSpeed / 10, 1 / 8) as double, 0));
    camera.backdrop.add(parallaxBackground);
  }

  void startGamePlay() async {
    _elementManager = ElementManager(gameRef: game);
    _elementManager.initializeElements();
    AudioManager.instance.stopBgm();
    AudioManager.instance.startBgm('gameBgm.wav');

    _player =
        Player(images.fromCache('players/player1/player.png'), playerData);

    await world.add(_player);
    await world.add(_elementManager);
    _actorInitialized = true;
  }

  // Method to disconnect actors and reset game state
  void _disconnectActors() {
    _player.removeFromParent();
    _elementManager.removeAllElements();
    _elementManager.removeFromParent();
  }

  // check if player has completed a task
  void checkTask() {
    TaskInfo task;
    int nbOfEachTask = 10;
    for (int i = 0; i < tasks.length; i++) {
      task = tasks[i];
      switch (task.type) {
        case TypeTask.run:
          if (playerData.currentDistance >= task.goal) {
            taskData.taskCompleted[TypeTask.run] = i % nbOfEachTask + 1;
          }
          break;
        case TypeTask.animal:
          if (playerData.nbAnimal >= task.goal) {
            taskData.taskCompleted[TypeTask.animal] = i % nbOfEachTask + 1;
          }
          break;
        case TypeTask.enemy:
          if (playerData.nbAnimal >= task.goal) {
            taskData.taskCompleted[TypeTask.enemy] = i % nbOfEachTask + 1;
          }
          break;
        case TypeTask.tree:
          if (playerData.nbTree >= task.goal) {
            taskData.taskCompleted[TypeTask.tree] = i % nbOfEachTask + 1;
          }
          break;
        case TypeTask.waste:
          if (playerData.nbWaste >= task.goal) {
            taskData.taskCompleted[TypeTask.waste] = i % nbOfEachTask + 1;
          }
          break;
        default:
          break;
      }
    }
  }

  // Method to reset the game
  void reset() {
    checkTask();
    _disconnectActors();
    playerData.currentScore = 0;
    playerData.currentDistance = 0;
    playerData.lives = 5;
    playerData.attack = 5;
    playerData.seed = 0;
    playerData.nbWaste = 0;
    playerData.nbAnimal = 0;
    playerData.nbTree = 0;
    playerData.nbEnemy = 0;
  }

  // Method called on every game update
  @override
  void update(double dt) {
    int incrementDistance = 1;
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }
    timer += ((objectSpeed * dt)).toInt();
    if (timer >= 8) {
      game.playerData.currentDistance += incrementDistance;
      game.playerData.currentScore += incrementDistance * 2;
      timer %= 10;
    }
    super.update(dt);
  }

  // Method called when a tap event occurs
  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(Hud.id)) {
      // jump if tap on right of the screen
      if (info.eventPosition.widget.x >= (sizeScreen.width / 2) &&
          !_player.isFly) {
        _player.jump();
      }
      // attack if tap on left of the screen
      if (info.eventPosition.widget.x < (sizeScreen.width / 2)) {
        _player.attack();
      }
    }

    super.onTapDown(info);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if ((keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
            keysPressed.contains(LogicalKeyboardKey.keyW)) &&
        !_player.isFly) {
      _player.jump();
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyQ)) {
      _player.attack();
    }

    return KeyEventResult.handled;
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

  Future<TaskData> _readTaskData() async {
    final taskDataBox = await Hive.openBox<TaskData>('WildRun.TaskDataBox');
    final taskData = taskDataBox.get('WildRun.TaskData');

    if (taskData == null) {
      await taskDataBox.put(
        'WildRun.TaskData',
        TaskData(),
      );
    }
    return taskDataBox.get('WildRun.TaskData')!;
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
          AudioManager.instance.resumeBgm();
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
        AudioManager.instance.pauseBgm();
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
