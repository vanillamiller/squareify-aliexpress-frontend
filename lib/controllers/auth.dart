import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/models/jwttoken.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'package:http/http.dart' as http;
import '../models/webStorage.dart';

/// An abstract class used as a mixin on protected routes
abstract class Protected {
  /// appropraite scope to access
  String get scope;

  /// returns true if user is authorized to access route otherwise
  /// returns false
  Future<bool> authorize() async {
    return WebStorage.getToken().then((token) {
      Map<String, dynamic> jsondecodedjwt = parseJwt(token);
      List<String> scopesList = jsondecodedjwt['scopes'].cast<String>();
      print(scopesList.contains(this.scope));
      return scopesList.contains(this.scope);
    }).catchError((e) {
      print('$e');
      throw e;
    });
  }
}

/// only builds protected widget page if calling authorize on protected
/// returns true, otherwise render error page
Widget authorizationEncorcer(Widget protectedRoute, RouteSettings settings) {
  Protected routeCast = protectedRoute as Protected;
  return FutureBuilder(
      future: routeCast.authorize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return protectedRoute;
        } else if (snapshot.hasError) {
          return ErrorView();
        }
        return CircularProgressIndicator();
      });
}

/// revokes Square token
Future<bool> signout() async {
  print('in signout');
  String encodedToken;
  try {
    encodedToken = await WebStorage.getToken();
  } on Exception catch (e) {
    print('something went wrog with token loading');
    throw e;
  }

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: encodedToken,
  };

  print(headers);
  http.Response response;

  try {
    response = await http.get(
        'https://7ec8t75vad.execute-api.ap-southeast-2.amazonaws.com/dev/signout',
        headers: headers);
  } catch (e) {
    print('$e');
    throw e;
  }
  print('${response.body}');

  return response.statusCode == 200 &&
      jsonDecode(response.body)['message'] == 'success';
}
