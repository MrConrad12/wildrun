import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/game/wildrun.dart';

// This represents the settings menu overlay.
class CardMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'CardMenu';
  // Reference to parent game.
  final WildRun game;
  List<CardItem> cards = [
    const CardItem(
        urlImage: 'assets/images/players/player1.png',
        nameCard: 'Gamer',
        descCard: 'You are a wild runner now!',
        typeCard: 'tree'),
  ];
  CardMenu(this.game, {super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: game.settings,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) => buildCard(item: cards[index]),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildCard({required CardItem item}) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(
            item.urlImage,
            fit: BoxFit.contain,
          ),
          Text(
            item.nameCard,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.descCard,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Apply",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );

// move it to card cardData
class CardItem {
  final String urlImage;
  final String nameCard;
  final String descCard;
  final String typeCard;
  const CardItem({
    required this.urlImage,
    required this.nameCard,
    required this.descCard,
    required this.typeCard,
  });
}
