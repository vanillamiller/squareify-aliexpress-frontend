import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/item.dart';

class PendingItem extends ChangeNotifier {
  Item _item;

  Item get item => _item;

  void addItem(Item item) {
    _item = item;
    notifyListeners();
  }
}
