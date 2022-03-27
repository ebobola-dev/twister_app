import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move_enums.dart';

@immutable
abstract class FortuneEvent {}

class FortuneSpinEvent extends FortuneEvent {
  final bool current;
  FortuneSpinEvent(this.current);
}

class FortuneChoiceEvent extends FortuneEvent {
  final String player;
  final BodyParts part;
  final Color color;
  FortuneChoiceEvent(this.player, this.part, this.color);
}

class FortuneSetStartEvent extends FortuneEvent {}
