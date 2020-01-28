import 'dart:io';

import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/login.dart';
import 'package:squareneumorphic/views/welcome.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';

import 'models/routing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => ErrorView(),
        '/welcome': (BuildContext context) => Welcome(),
        '/error': (BuildContext context) => ErrorView(),
        '/dashboard': (BuildContext context) => Dashboard()
      },
      initialRoute: '/welcome',
      onGenerateRoute: getRoute,
    );
  }
}
