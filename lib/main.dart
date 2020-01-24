import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _input = '';
  Cookie cookie;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15,
                spreadRadius: 1,
              )
            ]),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 300,
                        child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.fitHeight)),
                  ],
                ),
                TextFormField(
                  onSaved: (text) => setState(() => this._input = text),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      cookie = Cookie('id', _input);
                      cookie.secure = true;
                      print(cookie);
                      _launchURL(_input);
                    },
                    child: Text('submit'),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: RaisedButton(
                //     onPressed: () {
                //       print(cookie);
                //     },
                //     child: Text('submit'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_launchURL(String text) async {
  var url = 'https://squareupsandbox.com/oauth2/authorize?client_id=$text';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
