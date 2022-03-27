import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) => previous.seconds != current.seconds,
      builder: (context, state) => Text(
        state.getTime(),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
