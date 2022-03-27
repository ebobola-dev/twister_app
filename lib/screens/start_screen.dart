import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
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
                            child: const Text(
                              "Начать новую игру",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeAnimation(
                          from: AxisDirection.right,
                          child: ElevatedButton(
                            onPressed: null,
                            child: const Text(
                              "Посмотреть список игр (0)",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
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
