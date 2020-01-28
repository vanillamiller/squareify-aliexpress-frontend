import 'dart:io';

import 'package:flutter/material.dart';
import 'models/router.dart' as Router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';
    return MaterialApp(
      title: appTitle,
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => Welcome(),
      //   '/error': (BuildContext context) => ErrorView(),
      //   '/dashboard': (BuildContext context) => Dashboard()
      // },
      onGenerateRoute: Router.generateRoute,
    );
  }
}
