import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/squareItem.dart';
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
  AliItem _item;
  String _selectedImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _addedItemsProvider = Provider.of<AddedItems>(context);

    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<AliItem>(
              future: AliItem.load(widget._itemId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _item = snapshot.data;
                  print(_item.toSquareItem('selectedImage').toJson());
                  return Container(
                      width: mainTileWidth(context) * 0.8,
                      child: Column(
                        children: <Widget>[
                          ItemImageBar(
                            imageUrls: _item.images,
                          ),
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
                                    child: Text(_item.name),
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
                                    child: Text(_item.description),
                                  )),
                            ],
                          ),
                          ...buildOptionBarList(_item.options),
                        ],
                      ));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return CircularProgressIndicator();
              }),
          RaisedButton(onPressed: () async {
            print('button pressed');
            try {
              _item
                  .toSquareItem('placeholed')
                  .post()
                  .then((itemSuccessfullySent) {
                itemSuccessfullySent.log();
                _addedItemsProvider.addItem(itemSuccessfullySent);
              });
            } catch (e) {
              Text('error was: $e');
            }
          })
        ],
      ),
    );
  }
}

List<OptionBar> buildOptionBarList(List<Option> options) {
  return options.map<OptionBar>((opt) => new OptionBar(option: opt)).toList();
}

class ItemImageBar extends StatelessWidget {
  final List<String> _imageUrls;

  ItemImageBar({List<String> imageUrls}) : _imageUrls = imageUrls;
  @override
  Widget build(BuildContext context) => Container(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Text('Images')],
          ),
          Wrap(
            children: <ItemImage>[...insertImages(_imageUrls)],
          )
        ],
      ));

  List<ItemImage> insertImages(List<String> imageurls) =>
      imageurls.map<ItemImage>((url) => ItemImage(url: url)).toList();
}

class ItemImage extends StatelessWidget {
  final String _url;
  ItemImage({String url}) : _url = url;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 120,
          child: Image.network(
            _url,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
}

class OptionBar extends StatelessWidget {
  final Option _option;

  OptionBar({Option option}) : _option = option;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(_option.name)),
                ],
              ),
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
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Container(
            decoration: neumorphicBox,
            height: 80,
            width: 80,
            child: Center(
              child: Text(_choiceName),
            )),
      );
}
