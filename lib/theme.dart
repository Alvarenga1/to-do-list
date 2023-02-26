import 'package:flutter/material.dart';

const _seedColor = Color(0xff00908d);

final lightTheme = ThemeData(useMaterial3: true, colorSchemeSeed: _seedColor);
final darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _seedColor,
    brightness: Brightness.dark);
