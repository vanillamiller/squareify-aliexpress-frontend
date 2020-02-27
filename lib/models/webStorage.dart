import 'dart:convert';
import 'dart:html';

import 'package:squareneumorphic/models/jwttoken.dart';

import 'item.dart';
import 'squareItem.dart';

/// Represents localStorage from token and session storage
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

  /// gets token from local storage, otherwise throws exception
  static Future<String> getToken() async => _localStorage['token'] != null
      ? _localStorage['token']
      : throw Exception('there is no token!');

  /// removes token from local storage
  static Future<bool> invalidate() async {
    try {
      _localStorage.remove('token');
      return true;
    } catch (e) {
      return false;
    }
  }
}
