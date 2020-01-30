import 'package:flutter/cupertino.dart';

bool isLandscape(BuildContext context) =>
    MediaQuery.of(context).size.height <= MediaQuery.of(context).size.width;

num screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

num screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

num parentHeight(BoxConstraints constraints) => constraints.maxHeight;

num parentWidth(BoxConstraints constraints) => constraints.maxWidth;
