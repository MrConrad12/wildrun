import 'package:flame/components.dart';
import '../wildrun.dart';

class Task {
  final TypeTask typeTask;
  final int condition;
  Task({
    required this.typeTask,
    required this.condition,
  });
}

List<Task> tasks = [
  for (int i = 1; i < 10; i++)
    Task(
      typeTask: TypeTask.plant,
      condition: i * 10,
    ),
  for (int i = 1; i < 10; i++)
    Task(
      typeTask: TypeTask.animal,
      condition: i * 100,
    ),
  for (int i = 1; i < 10; i++)
    Task(
      typeTask: TypeTask.run,
      condition: i * 10000,
    ),
  for (int i = 1; i < 10; i++)
    Task(
      typeTask: TypeTask.waste,
      condition: i * 5,
    ),
];

class TaskManager extends Component with HasGameRef<WildRun> {}

enum TypeTask {
  run,
  animal,
  plant,
  waste,
}
