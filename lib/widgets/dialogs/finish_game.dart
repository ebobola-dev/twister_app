import 'package:flutter/material.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/animations/scale_on_create.dart';

class FinishGame extends StatelessWidget {
  final List<String> livePlayers;
  final Function(String) onChoiceWinner;
  final VoidCallback onRestartGame;
  final VoidCallback onCloseGame;
  const FinishGame({
    Key? key,
    required this.livePlayers,
    required this.onChoiceWinner,
    required this.onRestartGame,
    required this.onCloseGame,
  }) : super(key: key);

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
                "Вы хотите завершить игру".toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: const EdgeInsets.all(8.0),
            titlePadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
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
                    Column(
                      children: List.generate(
                        livePlayers.length,
                        (index) => FadeAnimation(
                          duration: const Duration(milliseconds: 300),
                          order: 4 + index,
                          orderDelay: 100,
                          from: index % 2 == 0
                              ? AxisDirection.left
                              : AxisDirection.right,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: InkWell(
                              onTap: () {
                                onChoiceWinner(livePlayers[index]);
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(.32),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Text(livePlayers[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                  order: livePlayers.length + 5,
                  orderDelay: 100,
                  child: TextButton(
                    onPressed: () {
                      onCloseGame();
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
                  order: livePlayers.length + 5,
                  orderDelay: 100,
                  child: TextButton(
                    onPressed: () {
                      onRestartGame();
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
                  order: livePlayers.length + 6,
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
  }
}
