import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:intl/intl.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/cards/player_chip.dart';
import 'package:twister_app/widgets/dialogs/game_info.dart';
import 'package:twister_app/widgets/square_button.dart';

class GameCard extends StatelessWidget {
  final GameState gameState;
  final double bottomMargin;
  final VoidCallback? onDelete;
  final VoidCallback? onTakePlayer;
  final VoidCallback? onContinueGame;
  const GameCard({
    Key? key,
    required this.gameState,
    this.onDelete,
    this.onTakePlayer,
    this.onContinueGame,
    this.bottomMargin = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPlayers = gameState.livePlayers + gameState.deadPlayers;
    final date =
        DateTime.fromMillisecondsSinceEpoch(gameState.millisecondsSinceEpoch);
    String strDate;
    switch (todayCheck(date)) {
      case -1:
        strDate = "Вчера, ${DateFormat.Hm().format(date)}";
        break;
      case 0:
        strDate = "Сегодня, ${DateFormat.Hm().format(date)}";
        break;
      default:
        strDate = DateFormat("d.MM").format(date);
        if (date.year != DateTime.now().year) {
          strDate += ".${date.year}";
        }
        strDate += " ${DateFormat.Hm().format(date)}";
    }
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(strDate),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Победитель:"),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      gameState.winner == null
                          ? "Игра не закончена"
                          : gameState.winner!,
                      style: TextStyle(
                        color: gameState.winner == null
                            ? moveColors.first
                            : moveColors.last,
                      ),
                    ),
                  ),
                  if (gameState.winner == null) ...[
                    const SizedBox(width: 5),
                    FaIcon(
                      FontAwesomeIcons.circleExclamation,
                      size: 18.0,
                      color: moveColors.first,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  allPlayers.length,
                  (index) => PlayerChip(
                    player: allPlayers[index],
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: allPlayers[index] == gameState.winner
                        ? moveColors.last
                        : null,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onDelete,
                  child: const Text("Удалить"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTakePlayer,
                  child: const Text("Взять игроков"),
                ),
              ),
              if (gameState.winner == null) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onContinueGame,
                    child: const Text("Продолжить игру"),
                  ),
                ),
              ],
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SquareButton(
              onTap: () => showDialog(
                context: context,
                builder: (context) => GameInfo(
                  moves: gameState.moves,
                  deadPlayers: gameState.deadPlayers,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
              child: const FaIcon(
                FontAwesomeIcons.circleInfo,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
