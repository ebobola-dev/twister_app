import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move_enums.dart';

@immutable
abstract class GameEvent {}

class GameRestartEvent extends GameEvent {}

class GameMoveEvent extends GameEvent {
  final BodyParts part;
  final Color color;
  GameMoveEvent({required this.part, required this.color});
}

class GameMoveLastEvent extends GameEvent {
  final BodyParts part;
  final Color color;
  GameMoveLastEvent({required this.part, required this.color});
}

class GameRemovePlayerEvent extends GameEvent {
  final String player;
  GameRemovePlayerEvent(this.player);
}

class GameFinishEvent extends GameEvent {
  final String winner;
  GameFinishEvent(this.winner);
}

class GameIncrementSeconds extends GameEvent {}
