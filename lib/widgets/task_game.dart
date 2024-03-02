import 'package:flutter/material.dart';

class TaskGame extends StatefulWidget {
  final Map taskData;
  const TaskGame({super.key, required this.taskData});

  @override
  State<TaskGame> createState() => _TaskGameState();
}

class _TaskGameState extends State<TaskGame> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage(
            'assets/images/cards/wolf1.jpg',
          ),
        ),
        title: const Text(
          "titre",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        subtitle: const Text("Decription of the taks"),
        trailing: IconButton(
            icon: Icon(isDone ? Icons.task_alt : Icons.access_time_rounded),
            iconSize: 40,
            onPressed: () {
              setState(() {
                isDone = !isDone;
              });
            }),
      ),
    );
  }
}
