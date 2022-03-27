import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twister_app/models/move/move.dart';

part 'game_state.g.dart';

@JsonSerializable()
class GameState extends Equatable {
  final String? winner;
  final List<String> livePlayers;
  final List<String> deadPlayers;
  final String movePlayer;
  final String? lastMovePlayer;
  final List<Move> moves;
  final int seconds;

  const GameState({
    required this.livePlayers,
    required this.deadPlayers,
    required this.movePlayer,
    this.lastMovePlayer,
    this.moves = const [],
    this.seconds = 0,
    this.winner,
  });

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  Map<String, dynamic> toJson() => _$GameStateToJson(this);

  GameState copyWith({
    List<String>? livePlayers,
    List<String>? deadPlayers,
    String? movePlayer,
    List<Move>? moves,
    int? seconds,
    String? lastMovePlayer,
    bool updateLastMove = false,
  }) =>
      GameState(
        livePlayers: livePlayers ?? this.livePlayers,
        deadPlayers: deadPlayers ?? this.deadPlayers,
        movePlayer: movePlayer ?? this.movePlayer,
        moves: moves ?? this.moves,
        lastMovePlayer: updateLastMove ? lastMovePlayer : this.lastMovePlayer,
        seconds: seconds ?? this.seconds,
      );

  GameState win(String winner) => GameState(
        winner: winner,
        livePlayers: [winner],
        deadPlayers: deadPlayers +
            livePlayers.where((element) => element != winner).toList(),
        movePlayer: winner,
        lastMovePlayer: null,
        seconds: seconds,
        moves: moves,
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

  String getTime() {
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
        return seconds_ > 9
            ? "$hours:$minutes:$seconds_"
            : "$minutes:0$seconds_";
      } else {
        return seconds_ > 9
            ? "$hours:0$minutes:$seconds_"
            : "0$minutes:0$seconds_";
      }
    }
  }
}
