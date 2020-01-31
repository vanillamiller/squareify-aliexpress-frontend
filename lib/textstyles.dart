import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squareneumorphic/utils.dart';

TextStyle heading(BuildContext context) => TextStyle(
      fontSize: isLandscape(context) ? 72 : 36,
      fontWeight: FontWeight.w700,
      color: Color(0xff2e3b4e),
    );

TextStyle button(BuildContext context) => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xff2e3b4e),
    );
