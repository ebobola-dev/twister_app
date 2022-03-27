import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/models/json_funcs.dart';

part 'move.g.dart';

@JsonSerializable()
class Move {
  final String player;
  final BodyParts part;
  @JsonKey(
    fromJson: colorFromString,
    toJson: colorToString,
  )
  final Color color;
  @JsonKey(
    fromJson: timeFromString,
    toJson: timeToString,
  )
  late final TimeOfDay time;

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
