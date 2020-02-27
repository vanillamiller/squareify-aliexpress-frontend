import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  static const path = '/error';
  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
              body: Center(
        child: Container(
          child: Text('Something went wrong',
              style: Theme.of(context).textTheme.headline1),
        ),
      )));
}
