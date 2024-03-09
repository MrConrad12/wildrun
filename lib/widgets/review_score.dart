import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildrun/models/player_data.dart';

class ReviewScore extends StatefulWidget {
  const ReviewScore({super.key});

  @override
  State<ReviewScore> createState() => _ReviewScoreState();
}

class _ReviewScoreState extends State<ReviewScore> {
  @override
  Widget build(BuildContext context) {
    const double iconSize = 20;

    return Row(
      children: [
        Selector<PlayerData, int>(
          selector: (_, playerData) => playerData.nbEnemy,
          builder: (_, enemy, __) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  const Icon(
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
                  const Icon(
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
                  const Icon(
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
                  const Icon(
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
    );
  }
}
