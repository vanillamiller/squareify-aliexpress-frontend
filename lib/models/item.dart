import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/aliItem.dart';

abstract class Item {
  @required
  final String _id;
  String _name;
  String _description;
  List<Option> _options;

  Item({String id, String name, String description, List<Option> options})
      : _id = id == null ? '' : id,
        _name = name == null ? '' : name,
        _description = description == null ? '' : description,
        _options = options == null ? new List<Option>() : options;

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

  void _addOption(Option selectedOption) {
    _options.add(selectedOption);
  }

  void _removeOption(Option selectedOptionToRemove, num index) {
    OptionValue selectedOptionValueToRemove = selectedOptionToRemove.values[0];
    _options[index].removeValue(selectedOptionValueToRemove);
  }

  void updateOption(Option optionToUpdate) {
    int index = -1;
    OptionValue valueToUpdate = optionToUpdate.values[0];
    for (var i = 0; i < _options.length; i++) {
      if (_options[i].name == optionToUpdate.name) {
        index = i;
        break;
      }
    }
    if (index > -1) {
      _options[index].contains(valueToUpdate) > -1
          ? this._removeOption(optionToUpdate, index)
          : this._addOption(optionToUpdate);
    } else {
      this._addOption(optionToUpdate);
    }
  }
}

class Option {
  String _name;
  List<OptionValue> _values;

  get values => _values;
  get name => _name;

  Option({String name, List<OptionValue> values})
      : _name = name,
        _values = values;

  static List<OptionValue> parseOptionValuermation(optionsInfoJson) {
    var listofOptionValue = optionsInfoJson as List;
    return listofOptionValue
        .map((optInfo) => OptionValue.fromJson(optInfo))
        .toList();
  }

  Map<String, dynamic> toSquareJson() => {
        "name": this._name,
        "values": _values.map((val) => val.toSquareJson()).toList()
      };

  void addValue(OptionValue valueToAdd) {
    this._values.add(valueToAdd);
  }

  void removeValue(OptionValue valueToRemove) {
    num index = this.contains(valueToRemove);
    if (index > -1) {
      this._values.removeAt(index);
    }
  }

  num contains(OptionValue value) {
    for (var i = 0; i < this._values.length; i++) {
      if (this._values[i].name == value.name) {
        return i;
      }
    }
    return -1;
  }

  factory Option.fromJson(Map<String, dynamic> json) => new Option(
      name: json['name'], values: parseOptionValuermation(json['values']));
}

class OptionValue {
  String _name;
  String _image;

  OptionValue({String name, String image})
      : _name = name,
        _image = image;

  get name => _name;
  get image => _image;

  Map<String, dynamic> toSquareJson() => {"name": this._name};

  factory OptionValue.fromJson(Map<String, dynamic> json) =>
      new OptionValue(name: json['name'], image: json['image']);
}
