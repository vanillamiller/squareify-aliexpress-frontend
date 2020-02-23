import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Waves extends StatelessWidget {
  Waves(this._colors);
  final List<List<Color>> _colors;

  @override
  Widget build(BuildContext context) => WaveWidget(
        duration: 1,
        config: CustomConfig(
          gradients: _colors,
          durations: [35000, 19440, 27000],
          heightPercentages: [0.20, 0.23, 0.18],
          gradientBegin: Alignment.centerRight,
          gradientEnd: Alignment.centerLeft,
        ),
        waveAmplitude: 10,
        backgroundColor: Colors.grey[100],
        size: Size(double.infinity, double.infinity),
      );
}

BoxDecoration neumorphicBox(String context) => BoxDecoration(
        color: Colors.grey[200],
        borderRadius: context == 'tile'
            ? BorderRadius.all(Radius.circular(30))
            : BorderRadius.all(Radius.circular(8)),
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
        ]);

BoxDecoration selectedBorder(String context) => BoxDecoration(
    borderRadius: context == 'tile'
        ? BorderRadius.all(Radius.circular(30))
        : BorderRadius.all(Radius.circular(8)),
    border: Border.all(width: 2, color: Colors.green));

BoxDecoration neumorphicCircle =
    BoxDecoration(shape: BoxShape.circle, color: Colors.grey[100],
        // borderRadius: BorderRadius.all(Radius.circular(30)),
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
    ]);
