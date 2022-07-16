import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/screens/game_screen/finish_view.dart';
import 'package:twister_app/screens/game_screen/game_view.dart';
import 'package:twister_app/screens/game_screen/widgets/header_timer.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/dialogs/finish_game.dart';
import 'package:twister_app/widgets/header/simple_header.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SimpleHeader(
            leading: BlocBuilder<GameBloc, GameState>(
              buildWhen: (previous, current) =>
                  previous.winner != current.winner,
              builder: (context, gameState) {
                final IconButton button;
                if (gameState.winner != null) {
                  button = IconButton(
                    key: const ValueKey(1),
                    onPressed: () {
                      animatedSwitchPage(
                        context,
                        const StartScreen(),
                        routeAnimation: RouteAnimation.slideLeft,
                        clearNavigator: true,
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.leftLong),
                  );
                } else {
                  button = IconButton(
                    key: const ValueKey(0),
                    onPressed: () {
                      final gameBloc = context.read<GameBloc>();
                      final livePlayers = gameBloc.state.livePlayers;
                      showDialog(
                        context: context,
                        builder: (context) => FinishGame(
                          livePlayers: livePlayers,
                          onChoiceWinner: (chosenWinner) => gameBloc.add(
                            GameFinishEvent(chosenWinner),
                          ),
                          onRestartGame: () => gameBloc.add(GameRestartEvent()),
                          onCloseGame: () => gameBloc.add(GameStopTimerEvent()),
                        ),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.flagCheckered),
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: button,
                );
              },
            ),
            title: const GameTimer(),
            fadeDuration: const Duration(milliseconds: 500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<GameBloc, GameState>(
            buildWhen: (previous, current) => previous.winner != current.winner,
            builder: (context, gameState) {
              if (gameState.winner != null) {
                return const FinishGameView();
              } else {
                return const GameView();
              }
            },
          ),
        ),
      ),
    );
  }
}
