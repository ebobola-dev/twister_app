import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum BodyParts {
  @JsonValue("left-hand")
  leftHand,
  @JsonValue("right-hand")
  rightHand,
  @JsonValue("left-foot")
  leftFoot,
  @JsonValue("right-foot")
  rightFoot,
}

const List<Color> moveColors = [
  Colors.red,
  Color(0xFF505FEE),
  Color(0xFFEFCD2C),
  Color(0xFF00C39A),
];

const Map<BodyParts, List<String>> translateParts = {
  BodyParts.leftFoot: ["Левая", "assets/svg/foot.svg", "Левая нога"],
  BodyParts.rightFoot: ["Правая", "assets/svg/foot.svg", "Правая нога"],
  BodyParts.leftHand: ["Левая", "assets/svg/hand.svg", "Левая рука"],
  BodyParts.rightHand: ["Правая", "assets/svg/hand.svg", "Правая рука"],
};

final Map<Color, String> translateColors = {
  Colors.red: "Красный",
  const Color(0xFF505FEE): "Синий",
  const Color(0xFFEFCD2C): "Жёлтый",
  const Color(0xFF00C39A): "Зелёный",
};

final List<List<Object>> movesList = [
  [
    translateParts[BodyParts.leftHand]!,
    moveColors[0],
    BodyParts.leftHand,
  ],
  [
    translateParts[BodyParts.rightHand]!,
    moveColors[0],
    BodyParts.rightHand,
  ],
  [
    translateParts[BodyParts.leftFoot]!,
    moveColors[0],
    BodyParts.leftFoot,
  ],
  [
    translateParts[BodyParts.rightFoot]!,
    moveColors[0],
    BodyParts.rightFoot,
  ],
  [
    translateParts[BodyParts.leftHand]!,
    moveColors[1],
    BodyParts.leftHand,
  ],
  [
    translateParts[BodyParts.rightHand]!,
    moveColors[1],
    BodyParts.rightHand,
  ],
  [
    translateParts[BodyParts.leftFoot]!,
    moveColors[1],
    BodyParts.leftFoot,
  ],
  [
    translateParts[BodyParts.rightFoot]!,
    moveColors[1],
    BodyParts.rightFoot,
  ],
  [
    translateParts[BodyParts.leftHand]!,
    moveColors[2],
    BodyParts.leftHand,
  ],
  [
    translateParts[BodyParts.rightHand]!,
    moveColors[2],
    BodyParts.rightHand,
  ],
  [
    translateParts[BodyParts.leftFoot]!,
    moveColors[2],
    BodyParts.leftFoot,
  ],
  [
    translateParts[BodyParts.rightFoot]!,
    moveColors[2],
    BodyParts.rightFoot,
  ],
  [
    translateParts[BodyParts.leftHand]!,
    moveColors[3],
    BodyParts.leftHand,
  ],
  [
    translateParts[BodyParts.rightHand]!,
    moveColors[3],
    BodyParts.rightHand,
  ],
  [
    translateParts[BodyParts.leftFoot]!,
    moveColors[3],
    BodyParts.leftFoot,
  ],
  [
    translateParts[BodyParts.rightFoot]!,
    moveColors[3],
    BodyParts.rightFoot,
  ],
];
