library parameters;

import 'package:flutter/material.dart';

class AppColors {
  static final mainColor = getMaterialColor(Color(0xFF2A2654));
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

InputDecoration logInField({String hint = ""}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        width: 0.7,
        color: AppColors.mainColor,
      ),
    ),
    hintText: hint,
    hintStyle: TextStyle(color: AppColors.mainColor.shade300),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        width: 1.5,
        color: AppColors.mainColor,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
  );
}
