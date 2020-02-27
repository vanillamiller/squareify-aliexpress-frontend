import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/authredirect.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'package:squareneumorphic/views/welcome.dart';

import '../controllers/auth.dart';

/// builds route if user has appropriate scope priveledges
Route<dynamic> _getRoute(RouteSettings settings, Widget view) =>
    MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) =>
            view is Protected ? authorizationEncorcer(view, settings) : view);

/// generates route based on url
Route<dynamic> generateRoute(RouteSettings settings) {
  RoutingData route = settings.name.getRoutingData;

  switch (route.path) {
    case WelcomeView.path:
      return _getRoute(settings, WelcomeView());
    case DashboardView.path:
      return _getRoute(settings, DashboardView());
    case ErrorView.path:
      return _getRoute(settings, ErrorView());
    case AuthRediect.path:
      return _getRoute(
          settings, AuthRediect(token: route._queryParameters['token']));
    default:
      return _getRoute(settings, ErrorView());
  }
}

/// represents the curerrent url in base and query parameters
class RoutingData {
  final String path;
  final Map<String, String> _queryParameters;
  RoutingData({
    this.path,
    Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;
  operator [](String key) => _queryParameters[key];
}

/// An extension on String that converts said String into RoutingData object
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
