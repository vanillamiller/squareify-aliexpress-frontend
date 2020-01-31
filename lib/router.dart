import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/errorpage.dart';
import 'package:squareneumorphic/views/login.dart';
import 'package:squareneumorphic/views/welcome.dart';

Route<dynamic> _getRoute(RouteSettings settings, Widget view) =>
    MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => view,
    );

Route<dynamic> generateRoute(RouteSettings settings) {
  RoutingData route = settings.name.getRoutingData;
  switch (route.path) {
    case Welcome.path:
      return _getRoute(settings, Welcome());
    case Dashboard.path:
      return _getRoute(settings, Dashboard());
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