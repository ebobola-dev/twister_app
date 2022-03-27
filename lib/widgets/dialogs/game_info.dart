import 'package:flutter/material.dart';
import 'package:twister_app/models/move/move.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/animations/scale_on_create.dart';
import 'package:twister_app/widgets/cards/player_chip.dart';
import 'package:twister_app/widgets/moves_list.dart';

class GameInfo extends StatelessWidget {
  final List<Move> moves;
  final List<String> deadPlayers;
  const GameInfo({
    Key? key,
    required this.moves,
    required this.deadPlayers,
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
                    const SizedBox(height: 10),
                    if (moves.isEmpty)
                      const FadeAnimation(
                        from: AxisDirection.right,
                        order: 3,
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "Ещё не было ходов",
                        ),
                      )
                    else
                      MovesList(moves: moves),
                    const SizedBox(
                      height: 10,
                    ),
                    if (deadPlayers.isEmpty)
                      Container()
                    else
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FadeAnimation(
                              from: moves.length % 2 == 0
                                  ? AxisDirection.left
                                  : AxisDirection.right,
                              duration: const Duration(milliseconds: 200),
                              order: moves.length + 8,
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
                                deadPlayers.length,
                                (index) => FadeAnimation(
                                  from: AxisDirection.down,
                                  duration: const Duration(milliseconds: 200),
                                  order: moves.length + index + 10,
                                  orderDelay: 100,
                                  child: PlayerChip(
                                    player: deadPlayers[index],
                                    padding: const EdgeInsets.all(8.0),
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
