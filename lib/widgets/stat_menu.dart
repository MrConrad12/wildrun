import 'dart:ui';

import 'package:flutter/material.dart';
import '/game/wildrun.dart';
import 'main_menu.dart';

// This represents the tasks menu overlay.
class StatMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'StatMenu';

  // Reference to parent game.
  final WildRun game;

  const StatMenu(this.game, {super.key});

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
            child: StatView(
              game: game,
            ),
          ),
        ),
      ),
    );
  }
}

class StatView extends StatefulWidget {
  final WildRun game;
  const StatView({super.key, required this.game});

  @override
  State<StatView> createState() => _StatViewState();
}

class _StatViewState extends State<StatView> {
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
    List<Map<String, dynamic>> dataPlayer = [
      {
        "name": "High score",
        "data": widget.game.playerData.highScore,
      },
      {
        "name": "Max distance",
        "data": widget.game.playerData.maxDistance,
      },
      {
        "name": "Total distance",
        "data": widget.game.playerData.totalDistance,
      },
      {
        "name": "Max tree",
        "data": widget.game.playerData.maxTree,
      },
      {
        "name": "Total tree",
        "data": widget.game.playerData.totalTree,
      },
      {
        "name": "Max animal",
        "data": widget.game.playerData.maxAnimal,
      },
      {
        "name": "Total animal",
        "data": widget.game.playerData.totalAnimal,
      },
      {
        "name": "Max waste",
        "data": widget.game.playerData.maxWaste,
      },
      {
        "name": "total waste",
        "data": widget.game.playerData.totalWaste,
      },
      {
        "name": "Max enemy",
        "data": widget.game.playerData.maxEnemy,
      },
      {
        "name": "total enemy",
        "data": widget.game.playerData.totalEnemy,
      },
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Your stat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.game.overlays.remove(StatMenu.id);
                  widget.game.overlays.add(MainMenu.id);
                  if (widget.game.actorInitialized) {
                    widget.game.reset();
                  }
                },
                icon: const Icon(Icons.cancel_outlined),
              )
            ],
          ),
          Expanded(
            child: AnimatedList(
              initialItemCount: dataPlayer.length,
              itemBuilder: (context, index, animation) => StatGame(
                game: widget.game,
                data: dataPlayer[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatGame extends StatefulWidget {
  final WildRun game;
  final Map data;

  const StatGame({
    super.key,
    required this.game,
    required this.data,
  });
  @override
  State<StatGame> createState() => _TaskGameState();
}

class _TaskGameState extends State<StatGame> {
  int value = 0;
  @override
  void initState() {
    super.initState();
    value = widget.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.data["name"];
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "$name: $value",
        style: const TextStyle(
            fontSize: 20, color: Color.fromARGB(255, 228, 226, 226)),
      ),
    );
  }
}
