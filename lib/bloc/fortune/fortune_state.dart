import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move_enums.dart';

abstract class FortuneState extends Equatable {}

class FortuneStartState extends FortuneState {
  @override
  List<Object> get props => [];
}

class FortuneSpinnigCurrentState extends FortuneState {
  @override
  List<Object> get props => [];
}

class FortuneSpinnigLastState extends FortuneState {
  @override
  List<Object> get props => [];
}

class FortuneChosenState extends FortuneState {
  final String player;
  final BodyParts part;
  final Color color;
  FortuneChosenState(this.player, this.part, this.color);

  @override
  List<Object> get props => [part, color];
}
