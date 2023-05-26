import 'package:flutter/material.dart';

/// light text button theme
final lightTextButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(
      Colors.redAccent.shade700,
    ),
  ),
);
