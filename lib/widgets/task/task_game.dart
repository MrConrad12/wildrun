import 'package:flutter/material.dart';
import '../../game/managers/task_manager.dart';

class TaskGame extends StatefulWidget {
  final TaskInfo taskData;
  const TaskGame({super.key, required this.taskData});

  @override
  State<TaskGame> createState() => _TaskGameState();
}

class _TaskGameState extends State<TaskGame> {
  @override
  Widget build(BuildContext context) {
    TaskInfo data = widget.taskData;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: data.hasDone ? const Color.fromARGB(228, 255, 255, 255) : null,
        border: Border.all(
          width: 2,
          color: data.color,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(
            data.icon,
            size: 50,
            color: data.color,
          ),
        ),
        title: Text(
          data.name,
          style: TextStyle(fontSize: 30, color: data.color),
        ),
        subtitle: Text(data.desc,
            style: TextStyle(
                fontSize: 20,
                color: data.hasDone
                    ? const Color.fromARGB(255, 107, 107, 107)
                    : const Color.fromARGB(255, 228, 226, 226))),
        trailing: IconButton(
          icon: Icon(data.hasDone ? Icons.task_alt : Icons.access_time_rounded),
          iconSize: 40,
          color: data.hasDone
              ? const Color.fromARGB(255, 22, 182, 62)
              : const Color.fromARGB(255, 228, 226, 226),
          onPressed: () {},
        ),
      ),
    );
  }
}
