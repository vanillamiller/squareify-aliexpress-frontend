import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/aliItem.dart';

abstract class Item {
  @required
  final String _id;
  String _name;
  String _description;
  List<Option> _options;

  Item({String id, String name, String description, List<Option> options})
      : _id = id,
        _name = name,
        _description = description,
        _options = options;

  String get id => _id;
  // set id(String id) => _id = id;

  String get name => _name;
  set name(String name) => _name = name;

  String get description => _description;
  set description(String desc) => _description = desc;

  List<Option> get options => _options;
  set options(List<Option> options) => _options = options;

  void log() {
    print(
        'LOGGING ITEM: id: $_id \n name: $name \n desc: $description \n options: $options');
  }

  @override
  String toString() {
    return 'id: $_id \n name: $name \n desc: $description \n options: $options';
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

  Map<String, dynamic> toSquareJson() => {
        "name": this._name,
        "values": _values.map((val) => val.toSquareJson()).toList()
      };

  void addValue(OptionInfo valueToAdd) {
    this._values.add(valueToAdd);
  }

  void removeValue(OptionInfo valueToRemove) {
    num index = this.contains(valueToRemove);
    if (index > -1) {
      this._values.removeAt(index);
    }
  }

  num contains(OptionInfo value) {
    for (var i = 0; i < this._values.length; i++) {
      if (this._values[i].name == value.name) {
        return i;
      }
    }
    return -1;
  }

  factory Option.fromJson(Map<String, dynamic> json) => new Option(
      name: json['name'], values: parseOptionInformation(json['values']));
}

class OptionInfo {
  String _name;
  String _image;

  OptionInfo({String name, String image})
      : _name = name,
        _image = image;

  get name => _name;
  get image => _image;

  Map<String, dynamic> toSquareJson() => {"name": this._name};

  factory OptionInfo.fromJson(Map<String, dynamic> json) =>
      new OptionInfo(name: json['name'], image: json['image']);
}
