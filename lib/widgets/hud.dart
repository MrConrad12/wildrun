import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildrun/game/wildrun.dart';

import '../game/managers/audio_manager.dart';
import '/models/player_data.dart';
import '/widgets/pause_menu.dart';

// This represents the head up display in game.
// It consists of, current score, high score,
// a pause button and number of remaining lives.
class Hud extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'Hud';

  // Reference to parent game.
  final WildRun game;

  const Hud(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.playerData,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, score, __) {
                    return Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.highScore,
                  builder: (_, highScore, __) {
                    return Text(
                      'High: $highScore',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                game.overlays.remove(Hud.id);
                game.overlays.add(PauseMenu.id);
                game.pauseEngine();
                AudioManager.instance.pauseBgm();
              },
              child: const Icon(Icons.pause, color: Colors.white),
            ),
            Column(
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.lives,
                  builder: (_, lives, __) {
                    return Row(
                      children: List.generate(5, (index) {
                        if (index < lives) {
                          return const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          );
                        } else {
                          return const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          );
                        }
                      }),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.attack,
                  builder: (_, attack, __) {
                    return Row(
                      children: List.generate(5, (index) {
                        if (index < attack) {
                          return const Icon(
                            Icons.cyclone_rounded,
                            color: Color.fromARGB(255, 58, 88, 255),
                          );
                        } else {
                          return const Icon(
                            Icons.cyclone_rounded,
                            color: Color.fromARGB(255, 168, 168, 168),
                          );
                        }
                      }),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
