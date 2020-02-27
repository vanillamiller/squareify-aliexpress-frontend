import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/views/squareitempane.dart';

/// Change notifier that stores items successfully sent to Square
class AddedItems extends ChangeNotifier {
  /// List of items sent to Square
  List<SquareItem> _addedItems = new List<SquareItem>();

  /// getter method of private list
  List<SquareItem> get list => _addedItems;

  /// returns amount of items sent to Square
  num get amount => _addedItems.length;

  /// returns a list of Square Tiles to be rendered in SquarePane
  List<SquareItemTile> toTile() =>
      _addedItems.reversed.map((item) => SquareItemTile(item: item)).toList();

  /// adds item to square and notifies listeners
  void addItem(SquareItem item) {
    print('adding item');
    _addedItems.add(item);
    notifyListeners();
  }
}
