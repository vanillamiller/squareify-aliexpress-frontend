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
import '../images.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/views/widgets.dart';

import 'dashboard.dart';

class AliItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Padding(
          padding: const EdgeInsets.all(16),
          child: ChangeNotifierProvider(
            create: (context) => SearchedItem(),
            child: ListView(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: neumorphicCircle, child: aliTiny(context))
                    ],
                  ),
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
                                ? SizedBox(
                                    height: 300,
                                    child: placeholderBoxImage(context))
                                : ItemView(itemId: pendingItem.itemId),
                      ))
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      );
}

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
                          ItemInputFieldContainer(
                            title: 'Images',
                            child: ItemImageBar(
                              imageUrls: _item.images,
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
                              controller: _itemController.descriptionController,
                            ),
                          ),
                          ItemInputFieldContainer(
                            title: 'Options',
                            child: Column(
                              children: <OptionBar>[
                                ...buildOptionBarList(_item.options),
                              ],
                            ),
                          ),
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
              return Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('could not send item to square')));
            });
          })
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
  Widget build(BuildContext context) => Container(
      width: mainTileWidth(context) * 0.75,
      child: Wrap(
        children: <ItemImage>[...insertImages(_imageUrls)],
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
    // Build a Form widget using the _formKey created above.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: mainTileWidth(context) * 0.6,
                // height: 200,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RaisedButton(
                color: Colors.grey[100],
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    String text = _urlInputController.text;
                    _searchedItemProvider.itemId = getItemId(text);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
