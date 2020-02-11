import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/models/jwttoken.dart';

import 'models/webStorage.dart';

abstract class Protected {
  String get scope;

  Future<bool> authorize() async {
    return WebStorage.getToken().then((token) {
      Map<String, dynamic> jsondecodedjwt = parseJwt(token);
      return jsondecodedjwt['scope'] == this.scope;
    }).catchError(() => false);
  }
}

Widget authorize(Protected protectedRoute) => FutureBuilder(
    future: protectedRoute.authorize(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return protectedRoute as Widget;
      }
    });
