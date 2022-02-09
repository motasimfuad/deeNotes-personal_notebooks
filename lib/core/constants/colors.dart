import 'package:flutter/material.dart';

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
