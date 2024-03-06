import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'card_data.g.dart';

@HiveType(typeId: 3)
class CardData extends ChangeNotifier with HiveObjectMixin {
  @HiveType(typeId: 0)
  Map<String, bool> _ownedCard = {};
  Map<String, bool> get ownedCard => _ownedCard;

  set ownedCard(Map<String, bool> value) {
    _ownedCard = value;
    notifyListeners();
    save();
  }
}
