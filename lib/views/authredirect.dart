import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/controllers/navigationService.dart';
import 'package:squareneumorphic/controllers/servicelocator.dart';
import 'package:squareneumorphic/models/webStorage.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';

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
              // locator<NavigationService>().navigateTo(DashboardView.path);
            } else if (snapshot.hasError) {
              // locator<NavigationService>().navigateTo(ErrorView.path);
            }
            return CircularProgressIndicator();
          })
      : ErrorView();
}
