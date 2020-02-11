import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'package:squareneumorphic/views/login.dart';
import 'package:squareneumorphic/views/welcome.dart';

import 'authorizor.dart';

Route<dynamic> _getRoute(RouteSettings settings, Widget view) =>
    MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) =>
            view is Protected ? authorize(view as Protected) : view);

Widget authorize(Protected protectedRoute) => FutureBuilder(
    future: protectedRoute.authorize(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return protectedRoute as Widget;
      }
    });

Route<dynamic> generateRoute(RouteSettings settings) {
  RoutingData route = settings.name.getRoutingData;

  switch (route.path) {
    case WelcomeView.path:
      return _getRoute(settings, WelcomeView());
    case DashboardView.path:
      return _getRoute(settings, DashboardView());
    case ErrorView.path:
      return _getRoute(settings, ErrorView());
    default:
      return _getRoute(settings, ErrorView());
  }
}

class RoutingData {
  final String path;
  final Map<String, String> _queryParameters;
  RoutingData({
    this.path,
    Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;
  operator [](String key) => _queryParameters[key];
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      path: uriData.path,
    );
  }
}
