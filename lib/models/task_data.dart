import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'task_data.g.dart';

@HiveType(typeId: 2)
class TaskData extends ChangeNotifier with HiveObjectMixin {
  @HiveType(typeId: 0)
  Map<String, bool> _taskCompleted = {};
  Map<String, bool> get taskCompleted => _taskCompleted;
  set taskCompleted(Map<String, bool> value) {
    _taskCompleted = value;
    notifyListeners();
    save();
  }
}
