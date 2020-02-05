import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/item.dart';
import 'package:squareneumorphic/models/pendingItem.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/widgets.dart';

import '../images.dart';
import 'itemview.dart';

class DashboardView extends StatelessWidget {
  static const path = '/dashboard';
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
            ),
          )
        ],
      ));
}

class AliItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Padding(
          padding: const EdgeInsets.all(16),
          // TODO: implement ChangeNotifier here
          child: ChangeNotifierProvider(
            create: (context) => PendingItem(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        // height: 150,
                        // width: 150,
                        decoration: neumorphicCircle,
                        child: aliTiny(context))
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
                        child: Consumer<PendingItem>(
                      builder: (context, pendingItem, child) =>
                          pendingItem.itemId == null
                              ? SizedBox(
                                  height: 300,
                                  child: placeholderBoxImage(context))
                              : ItemView(itemId: pendingItem.itemId),
                    ))
                  ],
                ),
              ],
            ),
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
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _urlInputController = TextEditingController();

  String getItemId(url) => RegExp("item\/[0-9]*\.html")
      .stringMatch(url)
      .replaceAll(RegExp("[^0-9]+"), '');

  @override
  Widget build(BuildContext context) {
    final _pendingItemProvider = Provider.of<PendingItem>(context);
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
                    _pendingItemProvider.itemId = getItemId(text);
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
