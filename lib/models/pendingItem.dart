import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/item.dart';

class PendingItem extends ChangeNotifier {
  Item _item;
  String _itemString;

  Item get item => _item;
  String get itemString => _itemString;

  set item(Item item) {
    _item = item;
    notifyListeners();
  }

  set itemString(String item) {
    _itemString = item;
    notifyListeners();
  }
}
