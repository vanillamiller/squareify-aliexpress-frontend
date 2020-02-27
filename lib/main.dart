import 'package:flutter/material.dart';
import 'package:squareneumorphic/routes/servicelocator.dart';
import 'package:squareneumorphic/themes.dart';
import 'routes/navigationService.dart';
import 'routes/router.dart' as Router;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appTitle = 'Squarify AliExpress';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: _appTitle,
        theme: basicTheme,
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      );
}
