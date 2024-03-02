import 'dart:ui';

import 'package:flutter/material.dart';

import '/game/wildrun.dart';
import 'main_menu.dart';
import 'task_game.dart';

// This represents the tasks menu overlay.
class TaskMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'TaskMenu';

  // Reference to parent game.
  final WildRun game;

  const TaskMenu(this.game, {super.key});

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

List<Map<String, String>> tasks = [
  {
    "name": "Tâche 1",
  },
  {
    "name": "Tâche 2",
  },
  {
    "name": "Tâche 3",
  },
  {
    "name": "Tâche 4",
  },
  {
    "name": "Tâche 4",
  },
  {
    "name": "Tâche 4",
  },
  {
    "name": "Tâche 4",
  },
  {
    "name": "Tâche 4",
  },
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
                "tasks : 1/10",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
              IconButton(
                  onPressed: () {
                    widget.game.overlays.remove(TaskMenu.id);
                    widget.game.overlays.add(MainMenu.id);
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ],
          ),
          Container(
              height: screenSize.height * .7,
              child: AnimatedList(
                initialItemCount: tasks.length,
                itemBuilder: (context, index, animation) => TaskGame(
                  taskData: tasks[index],
                ),
              )
              ),
        ],
      ),
    );
  }
}
