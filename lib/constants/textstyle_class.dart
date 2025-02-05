import 'package:flutter/material.dart';

const String primaryFontName = 'Inter';
double textHeight = 1.3;

class TextstyleClass {
  static TextStyle primaryFont400(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w400,
      color: color,
      height: textHeight,
      fontSize: size);

  static TextStyle primaryFont500(double size, Color color) => TextStyle(
      fontFamily: primaryFontName,
      fontWeight: FontWeight.w500,
      color: color,
      height: textHeight,
      fontSize: size);
}
