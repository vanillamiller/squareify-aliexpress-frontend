import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/login.dart';

Route<dynamic> getRoute(RouteSettings settings) {
  print(settings.name);
  print(settings.arguments);
  if (settings.name == '/login') {
    final String code = settings.arguments as String;
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginView(code),
    );
  }
  return null;
}
