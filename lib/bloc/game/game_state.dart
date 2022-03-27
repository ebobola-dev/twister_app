import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twister_app/models/move/move.dart';

part 'game_state.g.dart';

String _getTime(int seconds) {
  if (seconds < 60) {
    return seconds > 9 ? "00:$seconds" : "00:0$seconds";
  } else if (seconds < 3600) {
    final minutes = seconds ~/ 60;
    final seconds_ = seconds - 60 * minutes;
    if (minutes > 9) {
      return seconds_ > 9 ? "$minutes:$seconds_" : "$minutes:0$seconds_";
    } else {
      return seconds_ > 9 ? "0$minutes:$seconds_" : "0$minutes:0$seconds_";
    }
  } else {
    final hours = seconds ~/ 3600;
    final minutes = seconds ~/ 60 - 60 * hours;
    final seconds_ = seconds - 3600 * hours - 60 * minutes;
    if (minutes > 9) {
      return seconds_ > 9 ? "$hours:$minutes:$seconds_" : "$minutes:0$seconds_";
    } else {
      return seconds_ > 9
          ? "$hours:0$minutes:$seconds_"
          : "0$minutes:0$seconds_";
    }
  }
}

abstract class GameState extends Equatable {}

class GameNotStartedState extends GameState {
  @override
  List<Object> get props => [];
}

@JsonSerializable()
class GameStartedState extends GameState {
  final List<String> livePlayers;
  final List<String> deadPlayers;
  final String movePlayer;
  final String? lastMovePlayer;
  final List<Move> moves;
  final int seconds;

  GameStartedState({
    required this.livePlayers,
    required this.deadPlayers,
    required this.movePlayer,
    this.lastMovePlayer,
    this.moves = const [],
    this.seconds = 0,
  });

  factory GameStartedState.fromJson(Map<String, dynamic> json) =>
      _$GameStartedStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameStartedStateToJson(this);

  GameStartedState copyWith({
    List<String>? livePlayers,
    List<String>? deadPlayers,
    String? movePlayer,
    List<Move>? moves,
    int? seconds,
    String? lastMovePlayer,
    bool updateLastMove = false,
  }) =>
      GameStartedState(
        livePlayers: livePlayers ?? this.livePlayers,
        deadPlayers: deadPlayers ?? this.deadPlayers,
        movePlayer: movePlayer ?? this.movePlayer,
        moves: moves ?? this.moves,
        lastMovePlayer: updateLastMove ? lastMovePlayer : this.lastMovePlayer,
        seconds: seconds ?? this.seconds,
      );

  @override
  List<Object?> get props => [
        livePlayers,
        deadPlayers,
        movePlayer,
        lastMovePlayer,
        moves,
        seconds,
      ];

  List<Object?> get withoutSeconds => [
        livePlayers,
        deadPlayers,
        movePlayer,
        lastMovePlayer,
        moves,
      ];

  String getTime() => _getTime(seconds);
}

@JsonSerializable()
class GameFinishedState extends GameState {
  final String winner;
  final int seconds;
  final List<String> players;
  final List<Move> moves;

  GameFinishedState({
    required this.winner,
    required this.seconds,
    required this.players,
    required this.moves,
  });

  factory GameFinishedState.fromJson(Map<String, dynamic> json) =>
      _$GameFinishedStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameFinishedStateToJson(this);

  @override
  List<Object> get props => [
        winner,
        seconds,
        players,
        moves,
      ];

  String getTime() => _getTime(seconds);
}
