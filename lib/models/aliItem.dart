import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import '../controllers/itemmapper.dart' as ItemMapper;

class AliItem extends Item {
  List<String> _potentialImageurls;

  AliItem(
      {String id,
      String description,
      String name,
      List<Option> options,
      List<String> potentialImageurls})
      : _potentialImageurls = potentialImageurls,
        super(id: id, description: description, name: name, options: options);

  List<String> get images => _potentialImageurls;

  SquareItem toSquareItem(String selectedImage) => new SquareItem(
      id: this.id,
      name: this.name,
      description: this.description,
      options: this.options,
      imageUrl: selectedImage);

  static Future<AliItem> load(String id) =>
      ItemMapper.getAliExpressItemById(id);

  static List<Option> parseOptions(optionsJson) {
    var listOfOptions = optionsJson['options'] as List;
    return listOfOptions.map((opt) => Option.fromJson(opt)).toList();
  }

  static List<String> parseImageUrls(imagesJson) {
    var listofImages = imagesJson as List;
    return listofImages.map<String>((opt) => opt).toList();
  }

  factory AliItem.fromJson(Map<String, dynamic> json) => AliItem(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: json['description'] as String,
      options: parseOptions(json),
      potentialImageurls: parseImageUrls(json['images']));
}
