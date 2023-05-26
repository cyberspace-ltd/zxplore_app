import 'package:flutter/material.dart';

/// light elevated button theme
final lightElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(45),
    backgroundColor: Colors.redAccent.shade700,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    textStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
);
