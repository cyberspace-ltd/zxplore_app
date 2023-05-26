import 'package:flutter/material.dart';

/// dark text button theme
final darkTextButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(
      Colors.redAccent.shade700,
    ),
  ),
);
