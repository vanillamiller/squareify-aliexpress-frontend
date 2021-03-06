import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/controllers/auth.dart';
import 'package:squareneumorphic/models/option.dart';
import 'package:squareneumorphic/routes/navigationService.dart';
import 'package:squareneumorphic/routes/servicelocator.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/models/webStorage.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/views/dashboard.dart';
import 'package:squareneumorphic/views/welcome.dart';

import '../images.dart';

class SquareItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: (mainTileHeight(context) - 16) * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: squareTiny(context)),
                      ))
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: RaisedButton(
                        onPressed: () async {
                          print('button pressed');
                          bool signedOut =
                              await signout().then((success) async {
                            print('$success');
                            if (success) {
                              return await WebStorage.invalidate();
                            } else {
                              return false;
                            }
                          });
                          if (signedOut) {
                            print('signedout');
                            return locator<NavigationService>()
                                .navigateTo(WelcomeView.path);
                          } else {
                            return Scaffold.of(context).showSnackBar(SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Could not sign you out'),
                                ],
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text(
                          'sign out',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                  ))
            ],
          ),
          Container(
              height: (mainTileHeight(context) - 16) * 0.9,
              child: Consumer<AddedItems>(
                  builder: (context, addedItems, child) => ListView(
                        children: addedItems.toTile(),
                      ))),
        ],
      );
}

class SquareItemTile extends StatelessWidget {
  final SquareItem _item;

  SquareItemTile({SquareItem item}) : _item = item;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        width: constraints.maxWidth * 0.3,
                        child: Image.network(_item.imageUrl,
                            fit: BoxFit.fitWidth)),
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
                    ),
                    Container(
                        width: constraints.maxWidth * 0.55,
                        child: Text(_item.name, style: subHeading2(context))),
                    SizedBox(
                      width: constraints.maxWidth * 0.1,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(_item.description,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SquareItemOptionsChipsBar(
                          options: _item.options,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 4,
                )
              ],
            ),
          ),
        ),
      );
}

class SquareItemOptionsChipsBar extends StatelessWidget {
  SquareItemOptionsChipsBar({List<Option> options}) : _options = options;
  @required
  final List<Option> _options;

  Widget buildOptionBar(Option option, BuildContext context) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[Text(option.name, style: subHeading2(context))],
          ),
          SizedBox(
            width: mainTileWidth(context) - 32,
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: option.values
                  .map<Chip>((value) => Chip(
                      backgroundColor: Colors.green,
                      label: Text(value.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white))))
                  .toList(),
            ),
          ),
        ],
      );

  Widget optionBarFactory(List<Option> options, BuildContext context) => Column(
      children: options
          .map<Widget>((option) => buildOptionBar(option, context))
          .toList());

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Container(
          child: optionBarFactory(_options, context),
        ),
      );
}
