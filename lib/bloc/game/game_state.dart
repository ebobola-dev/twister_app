import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twister_app/models/move/move.dart';
import 'package:hive/hive.dart';

part 'game_state.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class GameState extends HiveObject with EquatableMixin {
  static const boxName = 'game_state_box';

  @HiveField(0)
  final int millisecondsSinceEpoch;
  @HiveField(1)
  final String? winner;
  @HiveField(2)
  final List<String> livePlayers;
  @HiveField(3)
  final List<String> deadPlayers;
  @HiveField(4)
  final String movePlayer;
  @HiveField(5)
  final String? lastMovePlayer;
  @HiveField(6)
  final List<Move> moves;
  @HiveField(7)
  final int seconds;
  @HiveField(8)
  GameState({
    this.millisecondsSinceEpoch = 0,
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
        millisecondsSinceEpoch: millisecondsSinceEpoch,
        livePlayers: livePlayers ?? this.livePlayers,
        deadPlayers: deadPlayers ?? this.deadPlayers,
        movePlayer: movePlayer ?? this.movePlayer,
        moves: moves ?? this.moves,
        lastMovePlayer: updateLastMove ? lastMovePlayer : this.lastMovePlayer,
        seconds: seconds ?? this.seconds,
      );

  GameState win(String winner) => GameState(
        millisecondsSinceEpoch: millisecondsSinceEpoch,
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

  save_() {
    Hive.box<GameState>(boxName).put(millisecondsSinceEpoch.toString(), this);
  }

  delete_() {
    Hive.box<GameState>(boxName).delete(millisecondsSinceEpoch.toString());
  }
}
