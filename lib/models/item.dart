class Item {
  String _id;
  String _name;
  String _description;
  Iterable<Map<String, Object>> _options;

  String get id => _id;
  set id(String id) => _id = id;

  String get name => _name;
  set name(String name) => _name = name;

  String get description => _description;
  set description(String desc) => _description = desc;

  Iterable<Map<String, List<String>>> get options => _options;
  set options(Iterable<Map<String, List<String>>> optiions) =>
      _options = options;
}
