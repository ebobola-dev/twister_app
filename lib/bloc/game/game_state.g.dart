// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStartedState _$GameStartedStateFromJson(Map<String, dynamic> json) =>
    GameStartedState(
      livePlayers: (json['livePlayers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      deadPlayers: (json['deadPlayers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      movePlayer: json['movePlayer'] as String,
      lastMovePlayer: json['lastMovePlayer'] as String?,
      moves: (json['moves'] as List<dynamic>?)
              ?.map((e) => Move.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      seconds: json['seconds'] as int? ?? 0,
    );

Map<String, dynamic> _$GameStartedStateToJson(GameStartedState instance) =>
    <String, dynamic>{
      'livePlayers': instance.livePlayers,
      'deadPlayers': instance.deadPlayers,
      'movePlayer': instance.movePlayer,
      'lastMovePlayer': instance.lastMovePlayer,
      'moves': instance.moves,
      'seconds': instance.seconds,
    };

GameFinishedState _$GameFinishedStateFromJson(Map<String, dynamic> json) =>
    GameFinishedState(
      winner: json['winner'] as String,
      seconds: json['seconds'] as int,
      players:
          (json['players'] as List<dynamic>).map((e) => e as String).toList(),
      moves: (json['moves'] as List<dynamic>)
          .map((e) => Move.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameFinishedStateToJson(GameFinishedState instance) =>
    <String, dynamic>{
      'winner': instance.winner,
      'seconds': instance.seconds,
      'players': instance.players,
      'moves': instance.moves,
    };
