import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/item.dart';

class ItemInputControllers {
  ItemInputControllers(Item item) : _loadedItem = item;
  final Item _loadedItem;
  TextEditingController nameController = new TextEditingController(),
      descriptionController = new TextEditingController();

  List<Option> selectedOptions = new List<Option>();
}
