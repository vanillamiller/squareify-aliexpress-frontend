import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/squareItem.dart';

class AddedItems extends ChangeNotifier {
  List<SquareItem> _addedItems;

  List<SquareItem> get addedItems => _addedItems;

  void addItem(SquareItem item) {
    _addedItems.add(item);
    notifyListeners();
  }
}
