import 'package:flutter/cupertino.dart';

class PendingItem extends ChangeNotifier {
  String _itemId;
  String get itemId => _itemId;

  set itemId(String itemid) {
    _itemId = itemid;
    notifyListeners();
  }
}
