import 'package:flutter/material.dart';

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
  final IconData icon;
  final TypeTask type;
  final int goal;
  final Color color;

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
      required this.icon,
      required this.type,
      required this.goal,
      required this.color});
}

Map<TypeTask, List> taskName = {
  TypeTask.tree: [
    "Promising sprout I",
    "Promising sprout II",
    "Promising sprout III",
    "Amateur botanist I",
    "Amateur botanist II",
    "Amateur botanist III",
    "Master gardener I",
    "Master gardener II",
    "Master gardener III",
    "Master of flora",
  ],
  TypeTask.animal: [
    "Animal friend I",
    "Animal friend II",
    "Animal friend III",
    "Man of the jungle I",
    "Man of the jungle II",
    "Man of the jungle III",
    "Beast Hero I",
    "Beast Hero II",
    "Beast Hero III",
    "Angel of the forest"
  ],
  TypeTask.waste: [
    "Conscientious collector I",
    "Conscientious collector II",
    "Conscientious collector IIIs",
    "Dump eradicator I",
    "Dump eradicator II",
    "Dump eradicator III",
    "Recycling champion  I",
    "Recycling champion  II",
    "Recycling champion  III",
    "Master of cleanliness"
  ],
  TypeTask.enemy: [
    "Guardian of clean air I",
    "Guardian of clean air II",
    "Guardian of clean air III",
    "Eco-Warrior I",
    "Eco-Warrior II",
    "Eco-Warrior III",
    "Ecosystem savior I",
    "Ecosystem savior II",
    "Ecosystem savior III",
    "Planet Hero ",
  ],
  TypeTask.run: [
    "Agile walker I",
    "Agile walker II",
    "Agile walker III",
    "Enduring runner I",
    "Enduring runner II",
    "Enduring runner III",
    "Determined marathoner I",
    "Determined marathoner II",
    "Determined marathoner III",
    "Ultimate run",
  ],
};

List<TaskInfo> tasks = [
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: taskName[TypeTask.run]?[i],
        color: const Color.fromARGB(255, 78, 119, 253),
        act: 'Run a total of',
        target: 'kilometers ',
        icon: Icons.keyboard_double_arrow_right_rounded,
        type: TypeTask.run,
        goal: (i + 1) * 2500 + 500 * i),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: taskName[TypeTask.animal]?[i],
        color: const Color.fromARGB(255, 255, 173, 50),
        act: 'Save',
        target: 'different animals',
        type: TypeTask.animal,
        icon: Icons.pets,
        goal: (i + 1) * 20 + i * 5),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: taskName[TypeTask.enemy]?[i],
        color: const Color.fromARGB(255, 253, 66, 66),
        act: 'Defeat',
        target: 'enemies',
        type: TypeTask.enemy,
        icon: Icons.bug_report_rounded,
        goal: (i + 1) * 15),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: taskName[TypeTask.tree]?[i],
        color: const Color.fromARGB(255, 71, 158, 0),
        act: 'Plant',
        target: 'tree',
        type: TypeTask.tree,
        icon: Icons.grass,
        goal: (i + 1) * 5 + i * 5),
  for (int i = 0; i < 10; i++)
    TaskInfo(
        idTask: i,
        name: taskName[TypeTask.waste]?[i],
        color: const Color.fromARGB(255, 174, 75, 255),
        act: 'Collect ',
        target: 'wastes',
        type: TypeTask.waste,
        icon: Icons.recycling_rounded,
        goal: (i + 1) * 20 + i * 5),
];
