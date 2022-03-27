import 'package:flutter/cupertino.dart';

@immutable
abstract class AddPlayerEvent {}

class AddPlayerChangeEvent extends AddPlayerEvent {
  final String newText;
  AddPlayerChangeEvent(this.newText);
}

class AddPlayerClearEvent extends AddPlayerEvent {}
