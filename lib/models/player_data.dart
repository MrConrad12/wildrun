import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'player_data.g.dart';

// This class stores the player progress presistently.
@HiveType(typeId: 0)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  int _lives = 5;

  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }

  // Data for score
  @HiveField(1)
  int highScore = 0;
  int _currentScore = 0;
  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    if (highScore < _currentScore) {
      highScore = _currentScore;
    }

    notifyListeners();
    save();
  }

  // Data for distance
  @HiveField(2)
  int maxDistance = 0;

  @HiveField(3)
  int totalDistance = 0;

  int _currentDistance = 0;
  int get currentDistance => _currentDistance;
  set currentDistance(int value) {
    _currentDistance = value;
    totalDistance += _currentDistance;
    if (maxDistance < _currentDistance) {
      maxDistance = _currentDistance;
    }
  }

  // Data for plant
  @HiveField(4)
  int maxTree = 0;

  @HiveField(5)
  int totalTree = 0;

  int _nbTree = 0;
  int get nbTree => _nbTree;
  set nbTree(int value) {
    _nbTree = value;
    totalTree += _nbTree;
    if (maxTree < _nbTree) {
      maxTree = _nbTree;
    }
  }

// Data for animal
  @HiveField(6)
  int maxAnimal = 0;

  @HiveField(7)
  int totalAnimal = 0;

  int _nbAnimal = 0;
  int get nbAnimal => _nbAnimal;
  set nbAnimal(int value) {
    _nbAnimal = value;
    totalAnimal += _nbAnimal;
    if (maxAnimal < _nbAnimal) {
      maxAnimal = _nbAnimal;
    }
  }

  // Data for waste
  @HiveField(8)
  int maxWaste = 0;

  @HiveField(9)
  int totalWaste = 0;

  int _nbWaste = 0;
  int get nbWaste => _nbWaste;
  set nbWaste(int value) {
    _nbWaste = value;
    totalWaste += _nbWaste;
    if (maxWaste < _nbWaste) {
      maxWaste = _nbWaste;
    }
  }

  // Data for enemy
  @HiveField(10)
  int maxEnemy = 0;

  @HiveField(11)
  int totalEnemy = 0;

  int _nbEnemy = 0;
  int get nbEnemy => _nbEnemy;
  set nbEnemy(int value) {
    _nbEnemy = value;
    totalEnemy += _nbEnemy;
    if (maxEnemy < _nbEnemy) {
      maxEnemy = _nbEnemy;
    }
  }
}
