import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wildrun/widgets/tuto/carousel.dart';
import '/game/wildrun.dart';
import 'main_menu.dart';

// This represents the tutos menu overlay.
class TutoMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'TutoMenu';
  // Reference to parent game.
  final WildRun game;

  const TutoMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Tutorial",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        game.overlays.remove(TutoMenu.id);
                        game.overlays.add(MainMenu.id);
                        if (game.actorInitialized) {
                          game.reset();
                        }
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    )
                  ],
                ),
                Expanded(child: Carousel(game)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
