import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/bloc/fortune/fortune_bloc.dart';
import 'package:twister_app/bloc/fortune/fortune_event.dart';
import 'package:twister_app/bloc/fortune/fortune_state.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/widgets/dialogs/game_info.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/widgets/square_button.dart';

import '../../widgets/cards/player_chip.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final StreamController<int> spinController =
      StreamController<int>.broadcast();
  final ScrollController _scrollController = ScrollController();
  Timer? _fortuneTimer;

  @override
  void initState() {
    final furtuneBloc = context.read<FortuneBloc>();
    final gameBloc = context.read<GameBloc>();
    spinController.stream.listen((index) {
      _fortuneTimer?.cancel();
      _fortuneTimer = Timer(const Duration(seconds: 3), () {
        final bool forCurrent = furtuneBloc.state is FortuneSpinnigCurrentState;
        final player = forCurrent
            ? gameBloc.state.movePlayer
            : gameBloc.state.lastMovePlayer!;
        final part = movesList[index][2] as BodyParts;
        final color = movesList[index][1] as Color;
        furtuneBloc.add(
          FortuneChoiceEvent(player, part, color),
        );
        if (forCurrent) {
          gameBloc.add(
            GameMoveEvent(part: part, color: color),
          );
        } else {
          gameBloc.add(
            GameMoveLastEvent(part: part, color: color),
          );
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_scrollController.hasClients) {
        await Future.delayed(const Duration(milliseconds: 1500));
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    spinController.close();
    _scrollController.dispose();
    _fortuneTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fortuneBloc = context.read<FortuneBloc>();
    final gameBloc = context.read<GameBloc>();
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: BlocBuilder<GameBloc, GameState>(
                  buildWhen: (previous, current) =>
                      previous.livePlayers != current.livePlayers,
                  builder: (context, gameState) => FadeAnimation(
                    from: AxisDirection.left,
                    order: 3,
                    duration: const Duration(milliseconds: 500),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        gameState.livePlayers.length,
                        (index) => PlayerChip(
                          player: gameState.livePlayers[index],
                          deleteColor: moveColors[index % 4],
                          onDelete: (player) =>
                              gameBloc.add(GameRemovePlayerEvent(player)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FadeAnimation(
                from: AxisDirection.right,
                order: 3,
                duration: const Duration(milliseconds: 500),
                child: SquareButton(
                  child: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: Colors.white,
                  ),
                  onTap: () {
                    final gameState = context.read<GameBloc>().state;
                    showDialog(
                      context: context,
                      builder: (context) => GameInfo(
                        moves: gameState.moves,
                        deadPlayers: gameState.deadPlayers,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: FadeAnimation(
              order: 4,
              duration: const Duration(milliseconds: 500),
              from: AxisDirection.left,
              child: FortuneWheel(
                duration: const Duration(seconds: 3),
                selected: spinController.stream,
                animateFirst: false,
                items: movesList.map(
                  (move) {
                    final list = move[0] as List;
                    return FortuneItem(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(list[0] as String),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            list[1],
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      style: FortuneItemStyle(
                        color: move[1] as Color,
                        textStyle: const TextStyle(fontFamily: "Montserrat"),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                FadeAnimation(
                  from: AxisDirection.right,
                  order: 5,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: 60,
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, gameState) =>
                          BlocBuilder<FortuneBloc, FortuneState>(
                        builder: (context, fortuneState) {
                          final Widget choice;
                          if (fortuneState is FortuneChosenState &&
                              gameState.moves.isNotEmpty) {
                            choice = Row(
                              key: const ValueKey(1),
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Text(
                                    fortuneState.player,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                const FaIcon(
                                  FontAwesomeIcons.rightLong,
                                ),
                                Flexible(
                                  child: RichText(
                                    textAlign: TextAlign.end,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "${translateParts[fortuneState.part]![2]} ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            translateColors[fortuneState.color]!
                                                .toLowerCase(),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: fortuneState.color,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            choice = const LoadingIndicator(
                              key: ValueKey(0),
                              indicatorType: Indicator.ballPulseRise,
                              colors: moveColors,
                            );
                          }
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: choice,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  from: AxisDirection.down,
                  order: 6,
                  duration: const Duration(milliseconds: 500),
                  child: BlocBuilder<GameBloc, GameState>(
                    buildWhen: (previous, current) =>
                        previous.movePlayer != current.movePlayer,
                    builder: (context, gameState) {
                      return BlocBuilder<FortuneBloc, FortuneState>(
                        builder: (context, fortuneState) => ButtonTheme(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: fortuneState.runtimeType !=
                                        FortuneSpinnigCurrentState &&
                                    fortuneState.runtimeType !=
                                        FortuneSpinnigLastState
                                ? () {
                                    spinController.add(
                                      Fortune.randomInt(0, movesList.length),
                                    );
                                    fortuneBloc.add(FortuneSpinEvent(true));
                                  }
                                : null,
                            child: Text(
                                "Крутить для игрока ${gameState.movePlayer}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<GameBloc, GameState>(
                  buildWhen: (previous, current) =>
                      previous.lastMovePlayer != current.lastMovePlayer,
                  builder: (context, gameState) {
                    final Widget button;
                    if (gameState.lastMovePlayer == null) {
                      button = Container(key: const ValueKey(0));
                    } else {
                      button = BlocBuilder<FortuneBloc, FortuneState>(
                        key: const ValueKey(1),
                        builder: (context, fortuneState) => FadeAnimation(
                          from: AxisDirection.down,
                          duration: const Duration(milliseconds: 500),
                          child: ButtonTheme(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: fortuneState.runtimeType !=
                                          FortuneSpinnigCurrentState &&
                                      fortuneState.runtimeType !=
                                          FortuneSpinnigLastState
                                  ? () {
                                      spinController.add(
                                        Fortune.randomInt(0, movesList.length),
                                      );
                                      fortuneBloc.add(FortuneSpinEvent(false));
                                    }
                                  : null,
                              child: Text(
                                  "Ещё раз для игрока ${gameState.lastMovePlayer}"),
                            ),
                          ),
                        ),
                      );
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: button,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
