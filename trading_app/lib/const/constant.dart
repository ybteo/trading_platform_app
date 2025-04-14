import 'package:flutter/material.dart';

int _greyScale = 0xFFEEEEEE;

int _blueScale = 0xFF359AFF;

MaterialColor grey = MaterialColor(
  _greyScale, 
  <int, Color>{
    50: const Color(0xFFF8F8F8),
    100: const Color(0xFFF0F0F0),
    200: Color(_greyScale),
    300: const Color(0xFFE0E0E0),
    400: const Color(0xFFDADADA),
    500: const Color(0xFFCCCCCC),
    600: const Color(0xFFBABABA),
    700: const Color(0xFFADADAD),
    800: const Color(0xFF979797),
    900: const Color(0xFF696868),
  }
);

MaterialColor blue = MaterialColor(
  _blueScale, 
  <int, Color>{
    50: const Color(0xFFA5D2FF),
    100: const Color(0xFF6DB6FF),
    200: const Color(0xFF67B3FF),
    300: const Color(0xFF4EA1F5),
    400: Color(_blueScale),
    500: const Color(0xFF1766B5),
    600: const Color(0xFF2262A1),
    700: const Color(0xFF1C5084),
    800: const Color(0xFF1B4876),
    900: const Color(0xFF0E355C),
  }
  
);