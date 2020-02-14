import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/models/jwttoken.dart';
import 'package:squareneumorphic/views/errorpage.dart';

import '../models/webStorage.dart';

abstract class Protected {
  String get scope;

  Future<bool> authorize() async {
    return WebStorage.getToken().then((token) {
      Map<String, dynamic> jsondecodedjwt = parseJwt(token);
      print(
          '++++++++++++++++ IN AUTHORIZER ${jsondecodedjwt['scopes']} +++++++++++++++++++++++++++');
      List<String> scopesList = jsondecodedjwt['scopes'].cast<String>();
      print(scopesList.contains(this.scope));
      return scopesList.contains(this.scope);
    }).catchError((e) {
      print('$e');
      return false;
    });
  }
}

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
