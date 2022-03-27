import 'package:flutter/material.dart';

@immutable
abstract class AddedPlayersEvent {}

class AddedPlayersAddEvent extends AddedPlayersEvent {
  final String name;
  AddedPlayersAddEvent(this.name);
}

class AddedPlayersRemoveEvent extends AddedPlayersEvent {
  final String name;
  AddedPlayersRemoveEvent(this.name);
}

class AddedPlayersClearEvent extends AddedPlayersEvent {}
