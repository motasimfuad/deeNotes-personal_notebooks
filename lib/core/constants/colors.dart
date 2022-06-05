import 'package:flutter/material.dart';

class KColors {
  static const grey = Color(0xffb4c9de);
  static const greyLight = Color(0xfff8f8fa);
  static const green = Color(0xff02A499);
  static const blue = Color(0xff1BB1E7);

  static const success = Color(0xff02a499);
  static const danger = Color(0xffec4561);
  static const warning = Color(0xfff8b425);
  static const info = Color(0xff38a4f8);

  static const secondary = Color(0xff333547);
  static const secondaryLight = Color(0xff383b4e);
  static const secondaryDark = Color(0xff292b38);

  static const primary = Colors.indigo;

  // static const int _primaryValue = 0xff626ed4;
  // static const MaterialColor primary = MaterialColor(
  //   _primaryValue,
  //   <int, Color>{
  //     50: Color(0xffeff1fb), //10%
  //     100: Color(0xffd0d4f2), //20%
  //     200: Color(0xffb1b7ea), //30%
  //     300: Color(0xff919ae1), //40%
  //     400: Color(0xff727dd8), //50%
  //     500: Color(_primaryValue), //60%
  //     600: Color(0xff5863bf), //70%
  //     700: Color(0xff4e58aa), //80%
  //     800: Color(0xff454d94), //90%
  //     900: Color(0xff31376a),
  //   },
  // );

// final MaterialColor kPrimary =
//     MaterialColor(const Color(0xff626ed4).value, _primaryMap);

}

final Map<int, Color> _darkMap = {
  50: Colors.brown[50] as Color,
  100: Colors.brown[100] as Color,
  200: Colors.brown[200] as Color,
  300: Colors.brown[300] as Color,
  400: Colors.brown[400] as Color,
  500: Colors.brown[900] as Color,
  600: Colors.brown[600] as Color,
  700: Colors.brown[700] as Color,
  800: Colors.brown[800] as Color,
  900: Colors.brown[900] as Color,
};

final MaterialColor darkSwatch =
    MaterialColor(Colors.brown[900]!.value, _darkMap);
