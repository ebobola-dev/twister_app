// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
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
      winner: json['winner'] as String?,
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'winner': instance.winner,
      'livePlayers': instance.livePlayers,
      'deadPlayers': instance.deadPlayers,
      'movePlayer': instance.movePlayer,
      'lastMovePlayer': instance.lastMovePlayer,
      'moves': instance.moves,
      'seconds': instance.seconds,
    };
