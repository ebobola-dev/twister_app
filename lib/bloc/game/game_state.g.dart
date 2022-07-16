// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStateAdapter extends TypeAdapter<GameState> {
  @override
  final int typeId = 0;

  @override
  GameState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameState(
      millisecondsSinceEpoch: fields[0] as int,
      livePlayers: (fields[2] as List).cast<String>(),
      deadPlayers: (fields[3] as List).cast<String>(),
      movePlayer: fields[4] as String,
      lastMovePlayer: fields[5] as String?,
      moves: (fields[6] as List).cast<Move>(),
      seconds: fields[7] as int,
      winner: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GameState obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.millisecondsSinceEpoch)
      ..writeByte(1)
      ..write(obj.winner)
      ..writeByte(2)
      ..write(obj.livePlayers)
      ..writeByte(3)
      ..write(obj.deadPlayers)
      ..writeByte(4)
      ..write(obj.movePlayer)
      ..writeByte(5)
      ..write(obj.lastMovePlayer)
      ..writeByte(6)
      ..write(obj.moves)
      ..writeByte(7)
      ..write(obj.seconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      millisecondsSinceEpoch: json['millisecondsSinceEpoch'] as int? ?? 0,
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
      'millisecondsSinceEpoch': instance.millisecondsSinceEpoch,
      'winner': instance.winner,
      'livePlayers': instance.livePlayers,
      'deadPlayers': instance.deadPlayers,
      'movePlayer': instance.movePlayer,
      'lastMovePlayer': instance.lastMovePlayer,
      'moves': instance.moves,
      'seconds': instance.seconds,
    };
