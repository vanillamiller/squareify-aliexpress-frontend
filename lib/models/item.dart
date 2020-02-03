import 'package:flutter/cupertino.dart';
import '../controllers/itemmappers.dart' as ItemMapper;

class Item {
  @required
  final String _id;
  String _name;
  String _description;
  List<String> _potentialImages;
  Iterable<Map<String, List<OptionInfo>>> _options;

  Item(
      {String id,
      String description,
      String name,
      Iterable<Map<String, List<OptionInfo>>> options,
      List<String> potentialImageurls})
      : _id = id,
        _description = description,
        _name = name,
        _options = options,
        _potentialImages = potentialImageurls;

  // Item(String id) : _id = id;

  void get() {}

  String get id => _id;
  // set id(String id) => _id = id;

  String get name => _name;
  set name(String name) => _name = name;

  String get description => _description;
  set description(String desc) => _description = desc;

  Iterable<Map<String, List<OptionInfo>>> get options => _options;
  set options(Iterable<Map<String, List<OptionInfo>>> optiions) =>
      _options = options;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'].toString(),
        name: json['name'],
        description: json['description'],
        options: json['variants']);
  }

  static Future<Item> load(String id) => ItemMapper.getAliExpressItemById(id);
}

class OptionInfo {
  String _name;
  String _image;

  OptionInfo({String name, String image})
      : _name = name,
        _image = image;

  get name => _name;
  get image => name;
}
