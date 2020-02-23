import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/views/dashboard.dart';

import '../images.dart';

class SquareItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: (mainTileHeight(context) - 16) * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: squareTiny(context),
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
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: option.values
                .map<Chip>((value) => Chip(
                    backgroundColor: Colors.green,
                    label: Text(value.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white))))
                .toList(),
          ),
        ],
      );

  Widget optionBarFactory(List<Option> options, BuildContext context) => Column(
      children: options
          .map<Widget>((option) => buildOptionBar(option, context))
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
