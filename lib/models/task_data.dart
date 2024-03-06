import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import '../game/managers/card_manager.dart';

part 'task_data.g.dart';

@HiveType(typeId: 2)
class TaskData extends ChangeNotifier with HiveObjectMixin {
  @HiveType(typeId: 0)
  Map<TypeTask, int> _taskCompleted = {};
  Map<TypeTask, int> get taskCompleted => _taskCompleted;
  set taskCompleted(Map<TypeTask, int> value) {
    _taskCompleted = value;
    notifyListeners();
    save();
  }
}
