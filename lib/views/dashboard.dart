import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/widgets.dart';

class DashboardView extends StatelessWidget {
  static const path = '/dashboard';
  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(body: Dashboard(), backgroundColor: Colors.grey[100]));
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: neumorphicBox,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: neumorphicBox,
              ),
            ),
          )
        ],
      ));
}
