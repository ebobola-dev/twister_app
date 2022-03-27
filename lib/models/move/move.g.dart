// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoveAdapter extends TypeAdapter<Move> {
  @override
  final int typeId = 1;

  @override
  Move read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Move(
      player: fields[0] as String,
      part: fields[1] as BodyParts,
      color:
          Color(int.parse(fields[2].split('(0x')[1].split(')')[0], radix: 16)),
    )..time = TimeOfDay(
        hour: int.parse(fields[3].split(":")[0]),
        minute: int.parse(fields[3].split(":")[1]),
      );
  }

  @override
  void write(BinaryWriter writer, Move obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.player)
      ..writeByte(1)
      ..write(obj.part)
      ..writeByte(2)
      ..write(obj.color.toString())
      ..writeByte(3)
      ..write("${obj.time.hour}:${obj.time.minute}");
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
