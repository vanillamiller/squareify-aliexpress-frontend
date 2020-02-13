import 'dart:convert';
import 'dart:html';

import 'package:squareneumorphic/models/jwttoken.dart';

import 'item.dart';
import 'squareItem.dart';

class WebStorage {
  static final Storage _localStorage = window.localStorage;

  static Future<bool> saveToken(String token) async {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    try {
      _localStorage['token'] = token;
      print('token stored okay');
      return true;
    } catch (e) {
      throw Exception('could not store auth token in localstorage because $e');
    }
  }

  static Future<String> getToken() async => _localStorage['token'] != null
      ? _localStorage['token']
      : throw Exception('there is no token!');

  static Future invalidate() async {
    _localStorage.remove('token');
  }

  // static Future saveAddedItems(String savedItemsJsonString) async {
  //   _localStorage['addedItems'] = savedItemsJsonString;
  // }

  // static Future<List<SquareItem>> loadAddedItems() async {
  //   _localStorage.containsKey('addedItems')
  //       ? jsonDecode(_localStorage['addedItems']).map<SquareItem>(
  //           (itemjson) => new SquareItem.fromJson(jsonDecode(itemjson)))
  //       : new List<SquareItem>();
  // }
}
