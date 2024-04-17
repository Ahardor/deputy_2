library parameters;

import 'package:deputy_2/connection/types.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

late User currentUser;

Map<String, Chat> allChats = {};

var emailRegEx =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

late SharedPreferences settings;

String formatDate(DateTime date) {
  return "${date.day}.${date.month}.${date.year}";
}

String formatTime(DateTime date) {
  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

String formatDateTime(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:00Z";
}

class AppColors {
  static final mainColor = getMaterialColor(Color(0xFF006832));
  static final secondColor = getMaterialColor(Color(0xFF004933));
  static final lightColor = getMaterialColor(Color(0xFFbfffec));
  static final backColor = getMaterialColor(Color(0xFFFBFFFC));
  static final back2Color = getMaterialColor(Color(0xFFE8EBE9));
  static final accentColor = getMaterialColor(Color(0xFF628395));
  static final darkColor = getMaterialColor(Color(0xFF1A1A1A));
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

InputDecoration logInField({String hint = "", IconData icon = Icons.abc}) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      // borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        width: 0.7,
        color: AppColors.mainColor,
      ),
    ),
    hintText: hint,
    prefixIcon: Icon(
      icon,
      color: AppColors.secondColor,
      size: 30,
    ),
    hintStyle: TextStyle(color: AppColors.mainColor.shade300),
    focusedBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        width: 1.5,
        color: AppColors.mainColor,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
  );
}
