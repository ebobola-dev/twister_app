import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/screens/saved_games_screen.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/screens/create_players_screen/create_players_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/header/change_theme_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeAnimation(
                          from: AxisDirection.up,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: const ChangeThemeButton(
                              iconColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          child: ElevatedButton(
                            onPressed: () => animatedSwitchPage(
                              context,
                              CreatePlayersScreen(),
                              routeAnimation: RouteAnimation.slideBottom,
                            ),
                            child: const Text("Начать новую игру"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          from: AxisDirection.right,
                          child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<GameState>(GameState.boxName)
                                    .listenable(),
                            builder: (context, Box<GameState> box, _) =>
                                ElevatedButton(
                              onPressed: box.isNotEmpty
                                  ? () => animatedSwitchPage(
                                        context,
                                        const SavedGamesScreen(),
                                        routeAnimation: RouteAnimation.slideTop,
                                      )
                                  : null,
                              child:
                                  Text("Посмотреть список игр (${box.length})"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
