import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/controllers/authorizor.dart';
import 'package:squareneumorphic/models/addedItems.dart';
import 'package:squareneumorphic/models/aliItem.dart';
import 'package:squareneumorphic/models/searchedItem.dart';
import 'package:squareneumorphic/models/squareItem.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/widgets.dart';

import '../images.dart';
import 'itemview.dart';

class DashboardView extends StatelessWidget with Protected {
  static const path = '/dashboard';
  String get scope => 'items';

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(body: Dashboard(), backgroundColor: Colors.grey[100]));
}

// BoxConstraints mainTileConstraints(BuildContext context) =>
//     isLandscape(context) ? BoxConstraints() : BoxConstraints();

double mainTileWidth(BuildContext context) => screenWidth(context) / 2 - 96;
double mainTileHeight(BuildContext context) => screenHeight(context) - 48;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: ChangeNotifierProvider(
        create: (context) => AddedItems(),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32),
              child: Container(
                  // constraints: mainTileConstraints(context),
                  height: mainTileHeight(context),
                  width: mainTileWidth(context),
                  decoration: neumorphicBox,
                  child: AliItemView()),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                  height: mainTileHeight(context),
                  width: mainTileWidth(context),
                  decoration: neumorphicBox,
                  child: SquareItemView()),
            )
          ],
        ),
      ));
}

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
                        width: constraints.maxWidth * 0.2,
                        child: Image.network(_item.imageUrl,
                            fit: BoxFit.fitWidth)),
                    SizedBox(
                      width: constraints.maxWidth * 0.1,
                    ),
                    Container(
                        width: constraints.maxWidth * 0.7,
                        child: Text(_item.name))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: constraints.maxWidth,
                        child: Text(_item.description))
                  ],
                ),
                Row()
              ],
            ),
          ),
        ),
      );
}
