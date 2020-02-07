import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/squareItem.dart';

class AddedItems extends ChangeNotifier {
  List<SquareItem> _addedItems = new List<SquareItem>();

  List<SquareItem> get list => _addedItems;

  num get amount => _addedItems.length;

  List<Text> toText() => _addedItems.map((item) => Text(item.name)).toList();

  void addItem(SquareItem item) {
    _addedItems.add(item);
    notifyListeners();
  }
}