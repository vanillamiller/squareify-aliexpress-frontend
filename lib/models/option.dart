/// Contains the Option name eg."SIZE" and its values eg."S, M, L, XL"
class Option {
  String _name;
  List<OptionValue> _values;

  get values => _values;
  get name => _name;

  Option({String name, List<OptionValue> values})
      : _name = name,
        _values = values;

  /// returns list of option values from a JSON file
  static List<OptionValue> parseOptionValuermation(optionsInfoJson) {
    var listofOptionValue = optionsInfoJson as List;
    return listofOptionValue
        .map((optInfo) => OptionValue.fromJson(optInfo))
        .toList();
  }

  /// creates the Square acceptable json from options
  Map<String, dynamic> toSquareJson() => {
        "name": this._name,
        "values": _values.map((val) => val.toSquareJson()).toList()
      };

  /// add value to option
  void addValue(OptionValue valueToAdd) {
    this._values.add(valueToAdd);
  }

  /// remove value from option
  void removeValue(OptionValue valueToRemove) {
    num index = this.contains(valueToRemove);
    if (index > -1) {
      this._values.removeAt(index);
    }
  }

  /// returns true if contains value, otherwise false
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

/// Option value has a name and an image in AliExpress, and just a name for Square
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
