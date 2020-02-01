import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/widgets.dart';

import '../images.dart';

class DashboardView extends StatelessWidget {
  static const path = '/dashboard';
  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(body: Dashboard(), backgroundColor: Colors.grey[100]));
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
          child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(48),
            child: Container(
                height: screenHeight(context) - 64,
                width: screenWidth(context) / 2 - 96,
                decoration: neumorphicBox,
                child: AliItemView()),
          ),
          Padding(
            padding: const EdgeInsets.all(48),
            child: Container(
              height: screenHeight(context) - 64,
              width: screenWidth(context) / 2 - 96,
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
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
                      child: SizedBox(
                          height: 200, child: placeholderBoxImage(context)))
                ],
              ),
            ],
          ),
        ),
      );
}
// Card squareItemCard(BuildContext context, BoxConstraints constraints) =>
//     Card(child: SizedBox(
//       child : Container
//     ));

// Create a Form widget.
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 400,
                height: 200,
                child: TextFormField(
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
                    // If the form is valid, display a Snackbar.

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
