import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/animations/scale_on_create.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';

class FinishGame extends StatelessWidget {
  const FinishGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();
    final globalGameState = gameBloc.state as GameStartedState;
    final livePlayersCount = globalGameState.livePlayers.length;
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (contetx, globalState) {
        if (globalState is GameStartedState) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleOnCreate(
                child: AlertDialog(
                  title: FadeAnimation(
                    from: AxisDirection.up,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      "Вы хотите завершить игру".toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  contentPadding: const EdgeInsets.all(8.0),
                  titlePadding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                  actionsPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const FadeAnimation(
                            from: AxisDirection.left,
                            duration: Duration(milliseconds: 500),
                            order: 2,
                            child: Text(
                              "Выберите победителя",
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<GameBloc, GameState>(
                            buildWhen: (previous, current) {
                              if (previous is GameStartedState &&
                                  current is GameStartedState) {
                                return previous.seconds != current.seconds;
                              } else {
                                return previous != current;
                              }
                            },
                            builder: (context, gameState) {
                              gameState as GameStartedState;
                              return Column(
                                children: List.generate(
                                  gameState.livePlayers.length,
                                  (index) => FadeAnimation(
                                    duration: const Duration(milliseconds: 300),
                                    order: 4 + index,
                                    orderDelay: 100,
                                    from: index % 2 == 0
                                        ? AxisDirection.left
                                        : AxisDirection.right,
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          context.read<GameBloc>().add(
                                                GameFinishEvent(
                                                  gameState.livePlayers[index],
                                                ),
                                              );
                                          Navigator.pop(context);
                                        },
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor
                                                .withOpacity(.32),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                              gameState.livePlayers[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: double.infinity,
                      child: FadeAnimation(
                        from: AxisDirection.down,
                        duration: const Duration(milliseconds: 300),
                        order: livePlayersCount + 5,
                        orderDelay: 100,
                        child: TextButton(
                          onPressed: () {
                            gameBloc.add(GameSaveEvent());
                            animatedSwitchPage(
                              context,
                              const StartScreen(),
                              routeAnimation: RouteAnimation.slideLeft,
                              clearNavigator: true,
                            );
                          },
                          child: Text("Я закончу игру позже".toUpperCase()),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FadeAnimation(
                        from: AxisDirection.down,
                        duration: const Duration(milliseconds: 300),
                        order: livePlayersCount + 5,
                        orderDelay: 100,
                        child: TextButton(
                          onPressed: () {
                            gameBloc.add(GameRestartEvent());
                            Navigator.pop(context);
                          },
                          child: Text("НАЧАТЬ ЗАНОВО".toUpperCase()),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FadeAnimation(
                        from: AxisDirection.down,
                        duration: const Duration(milliseconds: 300),
                        order: livePlayersCount + 6,
                        orderDelay: 100,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Отмена".toUpperCase()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
