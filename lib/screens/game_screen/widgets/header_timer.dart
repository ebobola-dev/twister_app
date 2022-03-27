import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) {
        if (previous is GameStartedState && current is GameStartedState) {
          return previous.seconds != current.seconds;
        } else {
          return previous != current;
        }
      },
      builder: (context, state) {
        if (state is GameStartedState) {
          return Text(
            state.getTime(),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          );
        } else if (state is GameFinishedState) {
          return Text(
            state.getTime(),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
