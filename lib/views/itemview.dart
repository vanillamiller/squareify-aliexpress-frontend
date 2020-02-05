import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/views/widgets.dart';

import 'dashboard.dart';

class ItemView extends StatefulWidget {
  final String _itemId;
  ItemView({Key key, String itemId})
      : _itemId = itemId,
        super(key: key);
  @override
  State<StatefulWidget> createState() => ItemViewState();
}

class ItemViewState extends State<ItemView> {
  Future<Item> _item;

  @override
  void initState() {
    super.initState();
    _item = Item.load(widget._itemId);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Item>(
      future: _item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Item loadedItem = snapshot.data;
          return Container(
              width: mainTileWidth(context) * 0.8,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Text('Name: '),
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            child: Text(loadedItem.name),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Text('Description: '),
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            child: Text(loadedItem.description),
                          )),
                    ],
                  ),
                  ...optionBarBuilder(loadedItem.options)
                ],
              ));
          // return Container(
          //   color: Colors.green,
          // );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      });
}

List<OptionBar> optionBarBuilder(List<Option> options) {
  return options.map<OptionBar>((opt) => new OptionBar(option: opt)).toList();
}

class OptionBar extends StatelessWidget {
  final Option _option;

  OptionBar({Option option}) : _option = option;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(_option.name),
              Wrap(
                children: _option.values
                    .map<ChoiceTile>((value) => ChoiceTile(name: value.name))
                    .toList(),
              ),
            ],
          ),
        ),
      );
}

class ChoiceTile extends StatelessWidget {
  final String _choiceName;
  ChoiceTile({String name}) : _choiceName = name;

  @override
  Widget build(BuildContext context) => Container(
      decoration: neumorphicBox,
      height: 100,
      width: 100,
      child: Center(
        child: Text(_choiceName),
      ));
}
