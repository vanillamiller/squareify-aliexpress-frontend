import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/controllers/auth.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/squareitempane.dart';
import 'package:squareneumorphic/views/widgets.dart';
import 'aliitempane.dart';

/// Protected dashboard view, holds AliItemPane on the left and SquareItemPane on the
/// right
class DashboardView extends StatelessWidget with Protected {
  static const path = '/dashboard';
  String get scope => 'items';

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(body: Dashboard(), backgroundColor: Colors.grey[100]));
}

/// Sizing is relative to screen size
double mainTileWidth(BuildContext context) => isLandscape(context)
    ? screenWidth(context) / 2 - 64
    : screenWidth(context) * 0.86;
double mainTileHeight(BuildContext context) => isLandscape(context)
    ? screenHeight(context) - 64
    : screenHeight(context) * 0.86;

/// Dashboard UI, renders AliItemPand and SquareItemPane
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
            child: ChangeNotifierProvider(
          create: (context) => AddedItems(),
          child: Wrap(
            // alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32),
                child: Container(
                    height: mainTileHeight(context),
                    width: mainTileWidth(context),
                    decoration: neumorphicBox('tile'),
                    child: AliItemView()),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Container(
                    height: mainTileHeight(context),
                    width: mainTileWidth(context),
                    decoration: neumorphicBox('tile'),
                    child: SquareItemView()),
              )
            ],
          ),
        )),
      );
}
