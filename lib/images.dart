import 'package:flutter/cupertino.dart';
import 'package:squareneumorphic/utils.dart';

Image squareLogo(BuildContext context) => Image(
    image: AssetImage('assets/images/square.png'),
    fit: isLandscape(context) ? BoxFit.fitWidth : BoxFit.fitHeight);

Image tinySquareLogo(BuildContext context) => Image(
    image: AssetImage('assets/images/squaretiny.png'),
    fit: isLandscape(context) ? BoxFit.fitWidth : BoxFit.fitHeight);

Image aliLogo(BuildContext context) => Image(
    image: AssetImage('assets/images/aliexpress.png'),
    fit: isLandscape(context) ? BoxFit.fitWidth : BoxFit.fitHeight);

Image placeholderBoxImage(BuildContext context) =>
    Image(image: AssetImage('assets/images/box.png'), fit: BoxFit.contain);
