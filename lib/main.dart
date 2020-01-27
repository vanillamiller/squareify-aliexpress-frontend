import 'dart:io';

import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/login.dart';
import 'package:squareneumorphic/views/welcome.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/error.dart';
// import 'package:squareneumorphic/routes.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginView(),
        '/welcome': (BuildContext context) => Welcome(),
        '/error': (BuildContext context) => Error(),
        '/dashboard': (BuildContext context) => Dashboard()
      },
      initialRoute: '/welcome',
      // home: Scaffold(
      //   backgroundColor: Colors.grey[300],
      //   body: MyCustomForm(),
      // ),
    );
  }
}
