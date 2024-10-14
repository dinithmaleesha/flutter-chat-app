import 'package:flutter/material.dart';

class ColorPallet {
  static const mainColor = Color(0xFF703EFF);
  static const secondaryColor = Color(0xFF6134E5);
  static const blackColor = Color(0xFF000000);
  static const grayColor = Color(0xFF9A9A9A);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const white = Colors.white;
  static const red = Color(0xFFC62828);
  static const gray = Color(0xffe8edf3);
  static const containerBackground = Color(0xFFD1C4E9);

  static const mainGradient = LinearGradient(
    colors: [mainColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
