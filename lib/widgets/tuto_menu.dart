import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/tuto_data.dart';
import '/game/wildrun.dart';
import 'main_menu.dart';
import 'card/tuto_game.dart';

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
          padding: const EdgeInsets.all(20),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: CardView(
              game: game,
            ),
          ),
        ),
      ),
    );
  }
}

class CardView extends StatefulWidget {
  final WildRun game;
  const CardView({super.key, required this.game});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
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
              )),
              IconButton(
                  onPressed: () {
                    widget.game.overlays.remove(TutoMenu.id);
                    widget.game.overlays.add(MainMenu.id);
                    if (widget.game.actorInitialized) {
                      widget.game.reset();
                    }
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ],
          ),
          Expanded(
            // height: screenSize.height * .7,
            child: Scrollbar(
              thickness: 10,
              thumbVisibility: true,
              trackVisibility: true,
              controller: _scrollController,
              child: ListView.separated(
                separatorBuilder: (context, _) => const SizedBox(
                  width: 8,
                ),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: tutos.length,
                itemBuilder: (context, index) =>
                    TutoGame(tutoInfo: tutos[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
