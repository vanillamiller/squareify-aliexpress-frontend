import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/aliItem.dart';

import 'option.dart';

/// Abstract class that is extended by both AliItem and SquareItem
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

  /// Adds Option : value pair if no pre existing option, otherwise appends
  /// new value to current option
  void _addOption(Option selectedOption, num index) {
    if (index > -1) {
      _options[index].addValue(selectedOption.values[0]);
    } else {
      _options.add(selectedOption);
    }
  }

  /// Removes option from list if no values, otherwise removes value from option
  /// map
  void _removeOption(Option selectedOptionToRemove, num index) {
    OptionValue selectedOptionValueToRemove = selectedOptionToRemove.values[0];
    _options[index].removeValue(selectedOptionValueToRemove);
  }

  /// Either adds or removes option
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
          : this._addOption(optionToUpdate, index);
    } else {
      this._addOption(optionToUpdate, index);
    }
  }
}
