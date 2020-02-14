import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/controllers/authorizor.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/squareitempane.dart';
import 'package:squareneumorphic/views/widgets.dart';
import 'aliitempane.dart';

class DashboardView extends StatelessWidget with Protected {
  static const path = '/dashboard';
  String get scope => 'items';

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(body: Dashboard(), backgroundColor: Colors.grey[100]));
}

BoxConstraints mainTileConstraints = BoxConstraints(minWidth: 360);

double mainTileWidth(BuildContext context) => screenWidth(context) / 2 - 96;
double mainTileHeight(BuildContext context) => screenHeight(context) - 48;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: ChangeNotifierProvider(
        create: (context) => AddedItems(),
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          alignment: WrapAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32),
              child: Container(
                  constraints: mainTileConstraints,
                  height: mainTileHeight(context),
                  width: mainTileWidth(context),
                  decoration: neumorphicBox,
                  child: AliItemView()),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                  constraints: mainTileConstraints,
                  height: mainTileHeight(context),
                  width: mainTileWidth(context),
                  decoration: neumorphicBox,
                  child: SquareItemView()),
            )
          ],
        ),
      ));
}
