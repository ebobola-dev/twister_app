import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/animations/scale_on_create.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/widgets/cards/player_chip.dart';
import 'package:twister_app/widgets/moves_list.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleOnCreate(
          child: AlertDialog(
            title: FadeAnimation(
              from: AxisDirection.up,
              duration: const Duration(milliseconds: 500),
              child: Text(
                "История".toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
            contentPadding: const EdgeInsets.all(8.0),
            titlePadding: const EdgeInsets.all(8.0),
            actionsPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<GameBloc, GameState>(
                      buildWhen: (previous, current) =>
                          previous.seconds != current.seconds,
                      builder: (context, gameState) => FadeAnimation(
                        from: AxisDirection.left,
                        duration: const Duration(milliseconds: 500),
                        order: 2,
                        child: Text(
                          "Игра идёт уже ${gameState.getTime()}",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<GameBloc, GameState>(
                      buildWhen: (previous, current) =>
                          previous.withoutSeconds != current.withoutSeconds,
                      builder: (context, gameState) {
                        if (gameState.moves.isEmpty) {
                          return const FadeAnimation(
                            from: AxisDirection.right,
                            order: 3,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              "Ещё не было ходов",
                            ),
                          );
                        } else {
                          return MovesList(moves: gameState.moves);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<GameBloc, GameState>(
                      buildWhen: (previous, current) =>
                          previous.deadPlayers != current.deadPlayers,
                      builder: (context, gameState) {
                        if (gameState.deadPlayers.isEmpty) {
                          return Container();
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FadeAnimation(
                                  from: gameState.moves.length % 2 == 0
                                      ? AxisDirection.left
                                      : AxisDirection.right,
                                  duration: const Duration(milliseconds: 200),
                                  order: gameState.moves.length + 8,
                                  orderDelay: 100,
                                  child: const Text(
                                    "Выбывшие игроки:",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    gameState.deadPlayers.length,
                                    (index) => FadeAnimation(
                                      from: AxisDirection.down,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      order:
                                          gameState.moves.length + index + 10,
                                      orderDelay: 100,
                                      child: PlayerChip(
                                        player: gameState.deadPlayers[index],
                                        padding: const EdgeInsets.all(8.0),
                                        backgroundColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              FadeAnimation(
                from: AxisDirection.down,
                duration: const Duration(milliseconds: 500),
                order: 2,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Закрыть".toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
