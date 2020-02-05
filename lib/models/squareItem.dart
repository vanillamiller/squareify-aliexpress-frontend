import 'item.dart';

class SquareItem extends Item {
  String _imageUrl;
  SquareItem(
      {String id,
      String name,
      String description,
      List<Option> options,
      String imageUrl})
      : _imageUrl = imageUrl,
        super(id: id, name: name, description: description, options: options);
}
