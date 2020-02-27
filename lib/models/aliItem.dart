import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import '../controllers/itemMapper.dart' as ItemMapper;
import 'option.dart';

/// Representation of AliExpress Item schema
class AliItem extends Item {
  AliItem(
      {String id,
      String description,
      String name,
      List<Option> options,
      List<String> potentialImageurls})
      : _potentialImageurls = potentialImageurls,
        super(id: id, description: description, name: name, options: options);

  /// List of images attached to AliExpress item
  List<String> _potentialImageurls;
  List<String> get images => _potentialImageurls;

  /// converts AliExpress Item representation into Square Item
  SquareItem toSquareItem(String selectedImage) => new SquareItem(
      id: this.id,
      name: this.name,
      description: this.description,
      options: this.options,
      imageUrl: selectedImage);

  /// Static factory that returns an AliItem represented in the data source layer
  static Future<AliItem> load(String id) =>
      ItemMapper.getAliExpressItemById(id);

  /// parses JSON and converts it into AliItem
  static List<Option> parseOptions(optionsJson) {
    var listOfOptions = optionsJson['options'] as List;
    return listOfOptions.map((opt) => Option.fromJson(opt)).toList();
  }

  /// parses urls
  static List<String> parseImageUrls(imagesJson) {
    var listofImages = imagesJson as List;
    return listofImages.map<String>((opt) => opt).toList();
  }

  /// Factory that takes in JSON and returns an AliItem object
  factory AliItem.fromJson(Map<String, dynamic> json) => AliItem(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: json['description'] as String,
      options: parseOptions(json),
      potentialImageurls: parseImageUrls(json['images']));
}
