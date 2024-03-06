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
  final double iconSize = 20;
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
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentDistance,
                  builder: (_, distance, __) {
                    return Text(
                      'Distance: $distance',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                Row(
                  children: [
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.nbEnemy,
                      builder: (_, enemy, __) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bug_report_rounded,
                                size: iconSize,
                                color: Colors.white,
                              ),
                              Text(
                                ' $enemy',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.nbTree,
                      builder: (_, tree, __) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.grass,
                                size: iconSize,
                                color: Colors.white,
                              ),
                              Text(
                                ' $tree',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.nbAnimal,
                      builder: (_, animal, __) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.pets,
                                size: iconSize,
                                color: Colors.white,
                              ),
                              Text(
                                ' $animal',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.nbWaste,
                      builder: (_, waste, __) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.recycling_rounded,
                                size: iconSize,
                                color: Colors.white,
                              ),
                              Text(
                                ' $waste',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.seed,
                  builder: (_, seed, __) {
                    return Row(
                      children: List.generate(3, (index) {
                        if (index < seed) {
                          return const Icon(
                            Icons.auto_awesome_rounded,
                            color: Color.fromARGB(255, 255, 182, 23),
                          );
                        } else {
                          return const Icon(
                            Icons.auto_awesome_rounded,
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
