import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import '../game/managers/task_manager.dart';

part 'task_data.g.dart';

@HiveType(typeId: 2)
class TaskData extends ChangeNotifier with HiveObjectMixin {
  @HiveType(typeId: 0)
  Map<TypeTask, int> _taskCompleted = {
    TypeTask.tree: 0,
    TypeTask.animal: 0,
    TypeTask.waste: 0,
    TypeTask.enemy: 0,
    TypeTask.run: 0,
  };
  Map<TypeTask, int> get taskCompleted => _taskCompleted;
  set taskCompleted(Map<TypeTask, int> value) {
    _taskCompleted = value;
    notifyListeners();
    save();
  }
}
