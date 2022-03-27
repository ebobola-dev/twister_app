import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/models/json_funcs.dart';

part 'move.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Move {
  @HiveField(0)
  final String player;
  @HiveField(1)
  final BodyParts part;
  @HiveField(2)
  @JsonKey(
    fromJson: colorFromString,
    toJson: colorToString,
  )
  final Color color;
  @HiveField(3)
  @JsonKey(
    fromJson: timeFromString,
    toJson: timeToString,
  )
  late TimeOfDay time;

  Move({
    required this.player,
    required this.part,
    required this.color,
  }) {
    time = TimeOfDay.now();
  }

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);
}
