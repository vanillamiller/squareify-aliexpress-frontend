import 'package:flutter/cupertino.dart';

/// Change notifies for AliPane,
class SearchedItem extends ChangeNotifier {
  String _itemId = '';
  String get itemId => _itemId;

  set itemId(String itemid) {
    _itemId = itemid;
    notifyListeners();
  }

  void removeItem() {
    _itemId = '';
    notifyListeners();
  }
}
