// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyPartsAdapter extends TypeAdapter<BodyParts> {
  @override
  final int typeId = 2;

  @override
  BodyParts read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BodyParts.leftHand;
      case 1:
        return BodyParts.rightHand;
      case 2:
        return BodyParts.leftFoot;
      case 3:
        return BodyParts.rightFoot;
      default:
        return BodyParts.leftHand;
    }
  }

  @override
  void write(BinaryWriter writer, BodyParts obj) {
    switch (obj) {
      case BodyParts.leftHand:
        writer.writeByte(0);
        break;
      case BodyParts.rightHand:
        writer.writeByte(1);
        break;
      case BodyParts.leftFoot:
        writer.writeByte(2);
        break;
      case BodyParts.rightFoot:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyPartsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
