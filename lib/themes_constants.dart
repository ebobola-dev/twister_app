import 'package:flutter/material.dart';

const darkTheme = MyTheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7754B2),
  secondary: Color(0xFF2C314A),
  background: Color(0xFF181A28),
  text: Colors.white,
  disable: Colors.white,
  chip: Color(0xFF343642),
  snack: Color(0xFFF5F7FB),
);

const lightTheme = MyTheme(
  brightness: Brightness.light,
  primary: Color(0xFF4C9283),
  secondary: Color(0xFFF5F7FB),
  background: Colors.white,
  text: Color(0xFF222222),
  disable: Color(0xFF222222),
  chip: Color(0xFFe5e5e5),
  snack: Color(0xFF2C314A),
);

class MyTheme {
  final Brightness brightness;
  final Color primary;
  final Color secondary;
  final Color background;
  final Color text;
  final Color disable;
  final Color chip;
  final Color snack;

  const MyTheme({
    required this.brightness,
    required this.primary,
    required this.secondary,
    required this.background,
    required this.text,
    required this.disable,
    required this.chip,
    required this.snack,
  });
}
