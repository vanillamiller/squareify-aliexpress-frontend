import 'package:flutter/material.dart';
import 'package:squareneumorphic/controllers/servicelocator.dart';
import 'controllers/navigationService.dart';
import 'controllers/router.dart' as Router;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appTitle = 'AliExpress Squarifier';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: _appTitle,
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      );
}
