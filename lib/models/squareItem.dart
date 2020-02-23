import 'package:flutter/cupertino.dart';

import 'item.dart';
import '../controllers/itemmapper.dart' as ItemMapper;

class SquareItem extends Item with ChangeNotifier {
  String _imageUrl;
  SquareItem(
      {String id,
      String name,
      String description,
      List<Option> options,
      String imageUrl})
      : _imageUrl = imageUrl,
        super(id: id, name: name, description: description, options: options);

  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "desc": this.description,
        "image": this._imageUrl,
        "options": options.map((option) => option.toSquareJson()).toList()
      };

  Future<SquareItem> post() => ItemMapper.postItemToSquare(this);
}
