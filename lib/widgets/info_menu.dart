import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wildrun/widgets/main_menu.dart';
import '/game/wildrun.dart';

class InfoMenu extends StatelessWidget {
  static const id = 'InfoMenu';
  final WildRun game;

  const InfoMenu(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                        "Info",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        game.overlays.remove(InfoMenu.id);
                        game.overlays.add(MainMenu.id);
                        if (game.actorInitialized) {
                          game.reset();
                        }
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    )
                  ],
                ),
                ContentText(text: "About WildRun")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String text;
  const ContentText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }
}
