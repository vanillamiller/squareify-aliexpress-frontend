import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/images.dart';
import 'package:squareneumorphic/textstyles.dart';
import 'package:squareneumorphic/utils.dart';
import 'package:squareneumorphic/views/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatelessWidget {
  static const path = '/';
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: WelcomeBody(), backgroundColor: Colors.grey[100]);
}

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(flex: 4, child: Container()),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Waves([
                            [
                              Color(0xFFFFD460),
                              Color(0xFFFFCC75),
                            ],
                            [Color(0xffF07B3F), Color(0xffFF8E6C)],
                            [
                              Color(0xFFFF748C),
                              Color(0xFFEA5455),
                            ]
                          ]),
                        ))
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('Squarify AliExpress',
                              style: heading(context)),
                        )
                      ],
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.spaceBetween,
                      // alignment: WrapAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
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
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                  width: isLandscape(context)
                                      ? screenWidth(context) * 0.15
                                      : null,
                                  height: isLandscape(context)
                                      ? null
                                      : screenHeight(context) * 0.25,
                                  child: aliLogo(context)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
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
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                  width: isLandscape(context)
                                      ? screenWidth(context) * 0.15
                                      : null,
                                  height: isLandscape(context)
                                      ? null
                                      : screenHeight(context) * 0.25,
                                  child: squareLogo(context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 42),
                          child: RaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  tinySquareLogo(context),
                                  SizedBox(width: 10),
                                  Text('authorize', style: button(context))
                                ],
                              ),
                            ),
                            onPressed: () => _launchURL(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )),
      );
}

_launchURL() async {
  var url =
      'https://connect.squareup.com/oauth2/authorize?client_id=sq0idp-xt-Zcw3N2Fx4I-CIbh86Bg&scope=INVENTORY_WRITE';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}