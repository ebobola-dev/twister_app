import 'package:flutter/material.dart';

class FinishGameView extends StatelessWidget {
  final String winner;
  const FinishGameView({Key? key, required this.winner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("WINNER: $winner"),
    );
  }
}
