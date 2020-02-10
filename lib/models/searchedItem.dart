import 'package:flutter/cupertino.dart';

class SearchedItem extends ChangeNotifier {
  String _itemId;
  String get itemId => _itemId;

  set itemId(String itemid) {
    _itemId = itemid;
    notifyListeners();
  }
}
