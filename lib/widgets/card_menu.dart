import 'dart:ui';

import 'package:flutter/material.dart';

import '/game/wildrun.dart';
import 'main_menu.dart';
import 'card_game.dart';

// This represents the cards menu overlay.
class CardMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'CardMenu';

  // Reference to parent game.
  final WildRun game;

  const CardMenu(this.game, {super.key});

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

List<Map<String, String>> cards = [
  {"name": "Tâche 1", "asset": "assets/images/cards/bird1.jpg"},
  {"name": "Tâche 2", "asset": "assets/images/cards/bird2.jpg"},
  {"name": "Tâche 3", "asset": "assets/images/cards/hog1.jpg"},
  {"name": "Tâche 4", "asset": "assets/images/cards/hog2.jpg"},
  {"name": "Tâche 4", "asset": "assets/images/cards/run1.jpg"},
  {"name": "Tâche 4", "asset": "assets/images/cards/run2.jpg"},
  {"name": "Tâche 4", "asset": "assets/images/cards/run4.jpg"},
  {"name": "Tâche 4", "asset": "assets/images/cards/wolf1.jpg"},
]; // Ajoutez vos tâches ici

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
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                "Cards : 1/10",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
              IconButton(
                  onPressed: () {
                    widget.game.overlays.remove(CardMenu.id);
                    widget.game.overlays.add(MainMenu.id);
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ],
          ),
          Container(
            height: screenSize.height * .7,
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
                itemCount: cards.length,
                itemBuilder: (context, index) =>
                    CardGame(cardData: cards[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
