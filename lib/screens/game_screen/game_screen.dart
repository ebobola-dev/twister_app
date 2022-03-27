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
                  previous.runtimeType != current.runtimeType,
              builder: (context, gameState) {
                final IconButton button;
                if (gameState is GameFinishedState) {
                  button = IconButton(
                    key: const ValueKey(1),
                    onPressed: () {
                      animatedSwitchPage(
                        context,
                        const StartScreen(),
                        routeAnimation: RouteAnimation.slideLeft,
                        clearNavigator: true,
                      );
                      context.read<GameBloc>().add(GameSaveEvent());
                    },
                    icon: const FaIcon(FontAwesomeIcons.leftLong),
                  );
                } else {
                  button = IconButton(
                    key: const ValueKey(0),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const FinishGame(),
                    ),
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
            buildWhen: (previous, current) =>
                previous.runtimeType != current.runtimeType,
            builder: (context, state) {
              if (state is GameFinishedState) {
                return FinishGameView(winner: state.winner);
              } else if (state is GameStartedState) {
                return const GameView();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
