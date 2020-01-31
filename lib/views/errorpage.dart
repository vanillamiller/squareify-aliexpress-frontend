import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  static const path = '/error';
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
                    child: Text('Something went wrong')))),
      );
}