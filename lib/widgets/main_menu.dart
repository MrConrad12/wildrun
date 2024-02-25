import 'dart:ui';

import 'package:flutter/material.dart';
import '/widgets/hud.dart';
import '/game/wildrun.dart';
import '/widgets/settings_menu.dart';

class MainMenu extends StatelessWidget {
  static const id = "MainMenu";
  final WildRun game;
  const MainMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          tooltip: 'view info',
                          onPressed: () {},
                          icon: const Icon(Icons.info_outline_rounded)),
                      IconButton(
                          tooltip: 'view tasks',
                          onPressed: () {},
                          icon: const Icon(Icons.task_alt)),
                      IconButton(
                          tooltip: 'view cards',
                          onPressed: () {},
                          icon: const Icon(Icons.content_copy_outlined)),
                      IconButton(
                          tooltip: 'go to store',
                          onPressed: () {},
                          icon: const Icon(Icons.store)),
                      IconButton(
                          tooltip: 'go to settings',
                          onPressed: () {
                            game.overlays.remove(MainMenu.id);
                            game.overlays.add(SettingsMenu.id);
                          },
                          icon: const Icon(Icons.settings)),
                    ],
                  ),
                  Image.asset(
                    'assets/brand/wildrun_logo.png',
                    fit: BoxFit.contain,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        game.startGamePlay();
                        game.overlays.remove(MainMenu.id);
                        game.overlays.add(Hud.id);
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
