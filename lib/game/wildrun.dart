import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import '/game/player.dart';

class WildRun extends FlameGame with TapDetector, HasCollisionDetection {
  WildRun({super.camera});
  //images
  static const _imageAssets = [
    'parallax/plx-1.png',
    'parallax/plx-2.png',
    'parallax/plx-3.png',
    'parallax/plx-4.png',
    'parallax/plx-5.png',
    'parallax/plx-6.png',
    'parallax/plx-7.png',
    'parallax/plx-8.png',
    'players/player1/player.png'
  ];

  //audio
  static const _audioAssets = [
    //plaec of auidio
  ];

  late Player _player;

  Vector2 get virtualSize => camera.viewport.virtualSize;

  @override
  Future<void> onLoad() async {
    // Makes the game full screen and landscape only.
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

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
    //_player = Player(images.fromCache('player_run.png'),playerData);
    /*_enemyManager();
    world.add(_player);
    world.add(_enemyManager);*/
  }
}
