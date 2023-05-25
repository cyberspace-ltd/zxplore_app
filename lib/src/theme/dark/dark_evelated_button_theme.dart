import 'package:flutter/material.dart';

/// dark elevated button theme
final darkElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(45),
    backgroundColor: const Color(0xff70C021),
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    textStyle: const TextStyle(
      // color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    foregroundColor: Colors.black,
  ),
);
