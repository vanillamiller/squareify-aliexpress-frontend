import 'package:flutter/material.dart';
import 'router.dart' as Router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _appTitle = 'AliExpress Squarifier';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
