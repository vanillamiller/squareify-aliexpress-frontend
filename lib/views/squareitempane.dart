import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/views/dashboard.dart';

class SquareItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      child: Consumer<AddedItems>(
          builder: (context, addedItems, child) => ListView(
                children: addedItems.toTile(),
              )));
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
                      width: constraints.maxWidth * 0.1,
                    ),
                    Container(
                        width: constraints.maxWidth * 0.5,
                        child: Text(_item.name, style: subHeading2(context))),
                    SizedBox(
                      width: constraints.maxWidth * 0.1,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: constraints.maxWidth,
                          child: Text(_item.description))
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    SquareItemOptionsChipsBar(
                      options: _item.options,
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xff2e3b4e),
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

  Container buildOptionBar(Option option, BuildContext context) => Container(
        width: mainTileWidth(context) * 0.75,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text(option.name)],
            ),
            Wrap(
              children: option.values
                  .map<Padding>((value) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: Chip(label: Text(value.name)),
                      ))
                  .toList(),
            ),
          ],
        ),
      );

  Widget optionBarFactory(List<Option> options, BuildContext context) => Column(
      children: options
          .map<Container>((option) => buildOptionBar(option, context))
          .toList());

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: optionBarFactory(_options, context),
        ),
      );
}
