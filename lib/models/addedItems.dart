import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/views/dashboard.dart';

import 'aliItem.dart';

class AddedItems extends ChangeNotifier {
  List<SquareItem> _addedItems = new List<SquareItem>();

  List<SquareItem> get list => _addedItems;

  num get amount => _addedItems.length;

  AliItem currentItem = new AliItem();

  String _selectedImageUrl = '';
  String get selectedImageUrl => _selectedImageUrl;

  List<SquareItemTile> toTile() =>
      _addedItems.map((item) => SquareItemTile(item: item)).toList();

  void addItem(SquareItem item) {
    this._selectedImageUrl = '';
    this.currentItem = new AliItem();
    _addedItems.add(item);
    notifyListeners();
  }

  set imageUrl(String url) {
    print('url = $url');
    _selectedImageUrl = url;
  }
}
