import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/cards/move_card.dart';

class MovesList extends StatelessWidget {
  final List<Move> moves;
  final Duration fadeDuration;
  final int orderDelay;
  final int startOrder;
  const MovesList({
    Key? key,
    required this.moves,
    this.fadeDuration = const Duration(milliseconds: 300),
    this.orderDelay = 100,
    this.startOrder = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        moves.length,
        (index) => FadeAnimation(
          from: index % 2 == 0 ? AxisDirection.left : AxisDirection.right,
          duration: fadeDuration,
          orderDelay: orderDelay,
          order: startOrder + index,
          child: MoveCard(move: moves[index]),
        ),
      ),
    );
  }
}
