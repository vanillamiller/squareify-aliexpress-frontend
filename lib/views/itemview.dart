import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/itemInputControllers.dart';
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
  AliItem _pendingItem;
  ItemInputControllers _itemController;
  @override
  void initState() {
    super.initState();
    _itemController = new ItemInputControllers();
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
                  _itemController.nameController.text = _item.name;
                  _itemController.descriptionController.text =
                      _item.description;
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
                                      child: ItemInputField(
                                          controller:
                                              _itemController.nameController))),
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
                                  child: ItemInputField(
                                    controller:
                                        _itemController.descriptionController,
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
            _item.name = _itemController.nameController.text;
            _item.description = _itemController.descriptionController.text;
            // print('+++++++ LOGGING ITEM ++++++++++');
            // _item.log();
            _item
                .toSquareItem(_addedItemsProvider.selectedImageUrl)
                .post()
                .then((itemSuccessfullySent) {
              print('here in the post return!!!!!!!!!!!!!!!!1');
              itemSuccessfullySent.log();
              _addedItemsProvider.addItem(itemSuccessfullySent);
            }).catchError((e) {
              print('here in the post catch error $e');
              print(e.stackTrace);
              return Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('could not send item to square')));
            });
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
  Widget build(BuildContext context) {
    final _addedItem = Provider.of<AddedItems>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {_addedItem.imageUrl = this._url},
        child: SizedBox(
          width: 120,
          child: Image.network(
            _url,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
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

class ItemInputField extends StatelessWidget {
  TextEditingController _controller;
  ItemInputField({TextEditingController controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _controller,
        maxLines: null,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff2e3b4e)))),
      );
}
