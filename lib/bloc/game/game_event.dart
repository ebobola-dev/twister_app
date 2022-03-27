import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move.dart';
import 'package:twister_app/models/move/move_enums.dart';

@immutable
abstract class GameEvent {}

class GameStartEvent extends GameEvent {
  final List<String> players;
  GameStartEvent(this.players);
}

class GameContinueGameEvent extends GameEvent {
  final List<String> livePlayers;
  final List<String> deadPlayers;
  final String movePlayer;
  final String? moveLastPlayers;
  final List<Move> moves;
  final int seconds;
  GameContinueGameEvent({
    required this.livePlayers,
    required this.deadPlayers,
    required this.movePlayer,
    required this.moves,
    required this.seconds,
    this.moveLastPlayers,
  });
}

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

class GameSaveEvent extends GameEvent {}

class GameIncrementSeconds extends GameEvent {}
