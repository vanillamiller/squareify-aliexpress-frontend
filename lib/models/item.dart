import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../controllers/itemmappers.dart' as ItemMapper;

class Item {
  @required
  final String _id;
  String _name;
  String _description;
  List<String> _potentialImages;
  List<Option> _options;

  Item(
      {String id,
      String description,
      String name,
      List<Option> options,
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

  List<Option> get options => _options;
  set options(List<Option> optiions) => _options = options;

  static Future<Item> load(String id) => ItemMapper.getAliExpressItemById(id);

  void log() {
    print('id: $_id, name: $name, desc: $description, options: $options');
  }

  static List<Option> parseOptions(optionsJson) {
    var listOfOptions = optionsJson['variationType'] as List;
    return listOfOptions.map((opt) => Option.fromJson(opt)).toList();
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    // print('${json['id']}');
    // print('${json['name']}');
    // print('${json['description']}');
    // print('${json['variationType']}');

    return Item(
        id: json['id'].toString(),
        name: json['name'] as String,
        description: json['description'] as String,
        options: parseOptions(json));
  }
}

class Option {
  String _name;
  List<OptionInfo> _values;

  get values => _values;
  get name => _name;

  Option({String name, List<OptionInfo> values})
      : _name = name,
        _values = values;

  static List<OptionInfo> parseOptionInformation(optionsInfoJson) {
    var listofOptionInfo = optionsInfoJson as List;
    return listofOptionInfo
        .map((optInfo) => OptionInfo.fromJson(optInfo))
        .toList();
  }

  factory Option.fromJson(Map<String, dynamic> json) => new Option(
      name: json['name'], values: parseOptionInformation(json['variant']));
}

class OptionInfo {
  String _name;
  String _image;

  OptionInfo({String name, String image})
      : _name = name,
        _image = image;

  get name => _name;
  get image => _image;

  factory OptionInfo.fromJson(Map<String, dynamic> json) =>
      new OptionInfo(name: json['name'], image: json['image']);
}
