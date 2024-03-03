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
            child: TaskView(
              game: game,
            ),
          ),
        ),
      ),
    );
  }
}

class TaskView extends StatefulWidget {
  final WildRun game;
  const TaskView({super.key, required this.game});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
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
                    widget.game.reset();
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ],
          ),
          Expanded(
              child: AnimatedList(
            initialItemCount: tasks.length,
            itemBuilder: (context, index, animation) => TaskGame(
              taskData: tasks[index].name,
            ),
          )),
        ],
      ),
    );
  }
}

enum TypeTask {
  tree,
  animal,
  waste,
  enemy,
  run,
}

class TaskInfo {
  final int idTask;
  final String name;
  final String act;
  final String target;
  final TypeTask type;
  final int goal;

  get desc => "$act $goal $target";
  bool _hasDone = false;
  get hasDone => _hasDone;
  set hasDone(value) {
    _hasDone = value;
  }

  TaskInfo(
      {required this.idTask,
      required this.name,
      required this.act,
      required this.target,
      required this.type,
      required this.goal});
}

List<TaskInfo> tasks = [
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: '',
        act: 'cover',
        target: 'distance',
        type: TypeTask.run,
        goal: i),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: '',
        act: 'save',
        target: 'animals',
        type: TypeTask.animal,
        goal: i),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: '',
        act: 'defeat',
        target: 'enemies',
        type: TypeTask.enemy,
        goal: i),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: '',
        act: 'plant',
        target: 'tree',
        type: TypeTask.tree,
        goal: i),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: '',
        act: 'recycle',
        target: 'wastes',
        type: TypeTask.waste,
        goal: i),
]; // Ajoutez vos tâches ici
