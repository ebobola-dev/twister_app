import 'package:flutter/material.dart';

Color colorFromString(String value) =>
    Color(int.parse(value.split('(0x')[1].split(')')[0], radix: 16));

String colorToString(Color color) => color.toString();

String timeToString(TimeOfDay time) => "${time.hour}:${time.minute}";

TimeOfDay timeFromString(String value) => TimeOfDay(
      hour: int.parse(value.split(":")[0]),
      minute: int.parse(value.split(":")[1]),
    );
