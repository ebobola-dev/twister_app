import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:twister_app/bloc/added_players/added_players_bloc.dart';
import 'package:twister_app/bloc/added_players/added_players_event.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/screens/create_players_screen/create_players_screen.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';

class FinishGameView extends StatefulWidget {
  const FinishGameView({Key? key}) : super(key: key);

  @override
  State<FinishGameView> createState() => _FinishGameViewState();
}

class _FinishGameViewState extends State<FinishGameView>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late final AnimationController _scaleController;
  late final Animation<double> _scale;

  @override
  void initState() {
    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scale = Tween(begin: 1.0, end: 0.0).animate(_scaleController);
    _animate();
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  _animate() async {
    await _lottieController.forward();
    _lottieController.stop();
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameBloc>();
    final addedPlayersBloc = context.read<AddedPlayersBloc>();

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<GameBloc, GameState>(
                buildWhen: (previous, current) =>
                    previous.winner != current.winner,
                builder: (context, gameState) => FadeAnimation(
                  duration: const Duration(milliseconds: 200),
                  order: 5,
                  from: AxisDirection.up,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: gameState.winner,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        TextSpan(
                          text: " победил(а)!",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<GameBloc, GameState>(
                buildWhen: (previous, current) =>
                    previous.moves.length != current.moves.length,
                builder: (context, gameState) => FadeAnimation(
                  duration: const Duration(milliseconds: 200),
                  from: AxisDirection.up,
                  order: 6,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Всего сделано ходов: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        TextSpan(
                          text: gameState.moves.length.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeAnimation(
                duration: const Duration(milliseconds: 200),
                from: AxisDirection.down,
                order: 7,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: ElevatedButton(
                    onPressed: () {
                      addedPlayersBloc.add(AddedPlayersClearEvent());
                      for (final players in gameBloc.state.deadPlayers) {
                        addedPlayersBloc.add(AddedPlayersAddEvent(players));
                      }
                      for (final players in gameBloc.state.livePlayers) {
                        addedPlayersBloc.add(AddedPlayersAddEvent(players));
                      }
                      animatedSwitchPage(
                        context,
                        CreatePlayersScreen(),
                        routeAnimation: RouteAnimation.slideLeft,
                        clearNavigator: true,
                      );
                    },
                    child: const Text("Сыграть ещё раз"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeAnimation(
                duration: const Duration(milliseconds: 200),
                from: AxisDirection.down,
                order: 8,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: ElevatedButton(
                    onPressed: () => animatedSwitchPage(
                      context,
                      const StartScreen(),
                      routeAnimation: RouteAnimation.slideRight,
                      clearNavigator: true,
                    ),
                    child: const Text("В главное меню"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          child: Opacity(
            opacity: .8,
            child: ScaleTransition(
              scale: _scale,
              child: Lottie.asset(
                "assets/lottie/victory_cup.json",
                controller: _lottieController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
