import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/routes/navigationService.dart';
import 'package:squareneumorphic/routes/servicelocator.dart';
import 'package:squareneumorphic/models/webStorage.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'dart:html' as html;

/// this is the page that is rendered while the token is being stored
/// will redirect to protected route if token is stored correctly, otherwise renders error page
class AuthRediect extends StatelessWidget {
  static const String path = '/authorize';
  final String _token;

  AuthRediect({String token}) : _token = token;

  @override
  Widget build(BuildContext context) => _token != null
      ? FutureBuilder(
          future: WebStorage.saveToken(_token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              redirect(DashboardView.path);
              return Scaffold(body: Center(child: Text('Welcome')));
            } else if (snapshot.hasError) {
              print('something went wrong storing the old token');
              redirect(ErrorView.path);
            }
            return CircularProgressIndicator();
          })
      : ErrorView();
}

/// redirect after 2 seconds of the token being stored
void redirect(String path) => Future.delayed(
      Duration(seconds: 2),
      () => locator<NavigationService>().navigateTo(DashboardView.path),
    );
