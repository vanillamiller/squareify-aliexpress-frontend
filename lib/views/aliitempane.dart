import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/images.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/itemInputControllers.dart';
import 'package:squareneumorphic/models/searchedItem.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import '../images.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/views/widgets.dart';

import 'dashboard.dart';

class AliItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            ChangeNotifierProvider(
          create: (context) => SearchedItem(),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: (mainTileHeight(context)) * 0.1,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: aliTiny(context),
                      ))
                ],
              ),
              Container(
                height: (mainTileHeight(context) - 16) * 0.9,
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AliUrlForm(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Consumer<SearchedItem>(
                              builder: (context, pendingItem, child) =>
                                  pendingItem.itemId == ''
                                      ? Column(
                                          children: <Widget>[
                                            SizedBox(height: 90),
                                            SizedBox(
                                                height: 300,
                                                child: placeholderBoxImage(
                                                    context)),
                                          ],
                                        )
                                      : ItemView(itemId: pendingItem.itemId),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class ItemView extends StatelessWidget {
  String _itemId;
  ItemInputControllers _itemController;
  ItemView({String itemId})
      : _itemId = itemId,
        _itemController = new ItemInputControllers();

  @override
  Widget build(BuildContext context) {
    final _addedItemsProvider = Provider.of<AddedItems>(context);
    final _searchedItemProvider = Provider.of<SearchedItem>(context);
    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<AliItem>(
              future: AliItem.load(_itemId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AliItem _loadedItem = snapshot.data;
                  _itemController.nameController.text = _loadedItem.name;
                  _itemController.descriptionController.text =
                      _loadedItem.description;
                  return ChangeNotifierProvider<SquareItem>(
                    create: (_) => SquareItem(
                        id: _itemId, imageUrl: _loadedItem.images[0]),
                    child: Container(
                        width: mainTileWidth(context) * 0.8,
                        child: Column(
                          children: <Widget>[
                            ItemInputFieldContainer(
                              title: 'Images',
                              child: ItemImageBar(
                                imageUrls: _loadedItem.images,
                              ),
                            ),
                            ItemInputFieldContainer(
                              title: 'Name',
                              child: ItemInputField(
                                controller: _itemController.nameController,
                              ),
                            ),
                            ItemInputFieldContainer(
                              title: 'Description',
                              child: ItemInputField(
                                controller:
                                    _itemController.descriptionController,
                              ),
                            ),
                            ItemInputFieldContainer(
                              title: 'Options',
                              child: Column(
                                children: <OptionBar>[
                                  ...buildOptionBarList(_loadedItem.options),
                                ],
                              ),
                            ),
                            Consumer<SquareItem>(
                              builder: (context, _itemToSend, __) =>
                                  RaisedButton(
                                      color: Colors.grey[100],
                                      child: Text(
                                        'Squarify',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      hoverColor: Colors.green,
                                      onPressed: () async {
                                        _itemToSend.name =
                                            _itemController.nameController.text;
                                        _itemToSend.description =
                                            _itemController
                                                .descriptionController.text;
                                        print('name is : ${_itemToSend.name}');
                                        _itemToSend.log();

                                        _itemToSend.post().then((res) {
                                          _addedItemsProvider
                                              .addItem(_itemToSend);
                                          _searchedItemProvider.removeItem();
                                          return Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    'item sent to square store'),
                                              ],
                                            ),
                                            backgroundColor: Colors.green,
                                          ));
                                        }).catchError((e) {
                                          print('$e');
                                          return Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    'could not send item to square'),
                                              ],
                                            ),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
                                      }),
                            )
                          ],
                        )),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }
}

class ItemInputFieldContainer extends StatelessWidget {
  ItemInputFieldContainer({String title, Widget child})
      : _title = title,
        _child = child;
  final String _title;
  final Widget _child;

  @override
  Widget build(BuildContext context) => Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  _title,
                  style: subHeading(context),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_child],
            )
          ],
        ),
      ));
}

List<OptionBar> buildOptionBarList(List<Option> options) {
  return options.map<OptionBar>((opt) => new OptionBar(option: opt)).toList();
}

class ItemImageBar extends StatelessWidget {
  final List<String> _imageUrls;

  ItemImageBar({List<String> imageUrls}) : _imageUrls = imageUrls;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: mainTileWidth(context) * 0.75,
        child: Wrap(
          children: <ItemImage>[...insertImages(_imageUrls)],
        ));
  }

  List<ItemImage> insertImages(List<String> imageurls) =>
      imageurls.map<ItemImage>((url) => ItemImage(url: url)).toList();
}

class ItemImage extends StatelessWidget {
  final String _url;
  ItemImage({String url}) : _url = url;
  @override
  Widget build(BuildContext context) {
    final _squareItemToSend = Provider.of<SquareItem>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {_squareItemToSend.imageUrl = this._url},
        child: Consumer<SquareItem>(
          builder: (context, _selectedItem, child) => Container(
            decoration: _selectedItem.imageUrl == this._url
                ? selectedBorder('image')
                : neumorphicBox('image'),
            width: 136,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _url,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
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
          width: mainTileWidth(context) * 0.75,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _option.name,
                        style: subHeading2(context),
                      )),
                ],
              ),
              Wrap(
                children: _option.values
                    .map<OptionTile>((value) => OptionTile(
                          valueName: value.name,
                          optionName: _option.name,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );
}

class OptionTile extends StatefulWidget {
  final String _valueName;
  final String _optionName;
  OptionTile({String valueName, String optionName})
      : _valueName = valueName,
        _optionName = optionName;

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    final _itemProvider = Provider.of<SquareItem>(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
          _itemProvider.updateOption(new Option(
              name: widget._optionName,
              values: <OptionValue>[new OptionValue(name: widget._valueName)]));
        },
        child: Container(
            decoration:
                _selected ? selectedBorder('tile') : neumorphicBox('tile'),
            height: 80,
            width: 80,
            child: Center(
              child: Text(
                widget._valueName,
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}

class ItemInputField extends StatelessWidget {
  TextEditingController _controller;
  ItemInputField({TextEditingController controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) => Container(
        width: mainTileWidth(context) * 0.75,
        child: TextFormField(
          controller: _controller,
          maxLines: null,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff2e3b4e)))),
        ),
      );
}

class AliUrlForm extends StatefulWidget {
  @override
  AliUrlFormState createState() => AliUrlFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class AliUrlFormState extends State<AliUrlForm> {
  final _formKey = GlobalKey<FormState>();
  var _urlInputController = TextEditingController();

  String getItemId(url) => RegExp("item\/[0-9]*\.html")
      .stringMatch(url)
      .replaceAll(RegExp("[^0-9]+"), '');

  @override
  Widget build(BuildContext context) {
    final _searchedItemProvider = Provider.of<SearchedItem>(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: mainTileWidth(context),
              child: Center(
                child: SizedBox(
                  width: mainTileWidth(context) * 0.8,
                  child: TextFormField(
                      controller: _urlInputController,
                      validator: (value) =>
                          RegExp("aliexpress\.com\/item\/[0-9]*\.html")
                                  .hasMatch(value)
                              ? null
                              : value.isEmpty
                                  ? "please enter an aliExpress item url"
                                  : "not a valid aliExpress item url"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    color: Colors.grey[100],
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        String text = _urlInputController.text;
                        _searchedItemProvider.itemId = getItemId(text);
                      }
                    },
                    child: Text('get item!',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
