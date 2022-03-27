// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Move _$MoveFromJson(Map<String, dynamic> json) => Move(
      player: json['player'] as String,
      part: $enumDecode(_$BodyPartsEnumMap, json['part']),
      color: colorFromString(json['color'] as String),
    )..time = timeFromString(json['time'] as String);

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      'player': instance.player,
      'part': _$BodyPartsEnumMap[instance.part],
      'color': colorToString(instance.color),
      'time': timeToString(instance.time),
    };

const _$BodyPartsEnumMap = {
  BodyParts.leftHand: 'left-hand',
  BodyParts.rightHand: 'right-hand',
  BodyParts.leftFoot: 'left-foot',
  BodyParts.rightFoot: 'right-foot',
};
