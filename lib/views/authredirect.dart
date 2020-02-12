import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/controllers/navigationService.dart';
import 'package:squareneumorphic/controllers/servicelocator.dart';
import 'package:squareneumorphic/models/webStorage.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'dart:html' as html;

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
            } else if (snapshot.hasError) {
              redirect(DashboardView.path);
              // locator<NavigationService>().navigateTo(ErrorView.path);
            }
            return CircularProgressIndicator();
          })
      : ErrorView();
}

class _Redirector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    redirect(DashboardView.path);
    return Scaffold(
        body: Center(
      child: RaisedButton(
          onPressed: () =>
              locator<NavigationService>().navigateTo(DashboardView.path)),
    ));
  }
}

void redirect(String path) => Future.delayed(
      Duration(seconds: 1),
      () => locator<NavigationService>().navigateTo(DashboardView.path),
    );
