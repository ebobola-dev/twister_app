import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twister_app/bloc/added_players/added_players_bloc.dart';
import 'package:twister_app/bloc/added_players/added_players_event.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/screens/create_players_screen/create_players_screen.dart';
import 'package:twister_app/screens/game_screen/game_screen.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/widgets/cards/game_card.dart';
import 'package:twister_app/widgets/header/simple_header.dart';

class SavedGamesScreen extends StatefulWidget {
  const SavedGamesScreen({Key? key}) : super(key: key);

  @override
  State<SavedGamesScreen> createState() => _SavedGamesScreenState();
}

class _SavedGamesScreenState extends State<SavedGamesScreen> {
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  Timer? _deleteAllTimer;

  @override
  void dispose() {
    _deleteAllTimer?.cancel();
    super.dispose();
  }

  void _toStartScreen() => animatedSwitchPage(
        context,
        const StartScreen(),
        routeAnimation: RouteAnimation.slideTop,
        clearNavigator: true,
      );

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SimpleHeader(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const FaIcon(FontAwesomeIcons.arrowLeftLong),
            ),
            title: const Text("СОХРАНЁННЫЕ ИГРЫ"),
            fadeDuration: const Duration(milliseconds: 200),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                FadeAnimation(
                  from: AxisDirection.up,
                  order: 3,
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final box = Hive.box<GameState>(GameState.boxName);
                        for (var i = box.length - 1; i >= 0; i--) {
                          _animatedListKey.currentState?.removeItem(
                            i,
                            (context, animation) => SizeTransition(
                              sizeFactor: animation,
                              child: GameCard(
                                  gameState: box.getAt(box.length - i - 1)!),
                            ),
                          );
                        }
                        _deleteAllTimer =
                            Timer(const Duration(milliseconds: 300), () {
                          box.deleteAll(box.keys);
                          _toStartScreen();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: moveColors.first),
                      child: const Text("Удалить все"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<GameState>(GameState.boxName).listenable(),
                    builder: (context, Box<GameState> box, _) => FadeAnimation(
                      from: AxisDirection.down,
                      order: 4,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedList(
                        key: _animatedListKey,
                        initialItemCount: box.length,
                        itemBuilder: (context, index, animation) {
                          final gameState = box.getAt(box.length - index - 1)!;
                          return GameCard(
                            gameState: gameState,
                            onDelete: () async {
                              _animatedListKey.currentState?.removeItem(
                                index,
                                (context, animation) => SizeTransition(
                                  sizeFactor: animation,
                                  child: GameCard(gameState: gameState),
                                ),
                              );
                              box.delete(
                                gameState.millisecondsSinceEpoch.toString(),
                              );
                              if (box.isEmpty) {
                                _toStartScreen();
                              }
                            },
                            onTakePlayer: () {
                              final addedPlayersBloc =
                                  context.read<AddedPlayersBloc>();
                              addedPlayersBloc.add(AddedPlayersClearEvent());
                              final allPlayers =
                                  gameState.livePlayers + gameState.deadPlayers;
                              for (final player in allPlayers) {
                                addedPlayersBloc
                                    .add(AddedPlayersAddEvent(player));
                              }
                              animatedSwitchPage(
                                context,
                                CreatePlayersScreen(),
                                routeAnimation: RouteAnimation.slideRight,
                              );
                            },
                            onContinueGame: () {
                              animatedSwitchPage(
                                context,
                                BlocProvider(
                                  create: (context) =>
                                      GameBloc(oldState: gameState),
                                  child: const GameScreen(),
                                ),
                                routeAnimation: RouteAnimation.slideBottom,
                                withBack: false,
                                clearNavigator: true,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    //   builder: (context, Box<GameState> box, _) => ListView(
                    //     children: List.generate(
                    //       box.length,
                    //       (index) => FadeAnimation(
                    //         child: GameCard(
                    //           gameState: box.values.toList()[index],
                    //           onDelete: () => box.delete(
                    //             box
                    //                 .getAt(index)!
                    //                 .millisecondsSinceEpoch
                    //                 .toString(),
                    //           ),
                    //         ),
                    //         from: index % 2 == 0
                    //             ? AxisDirection.left
                    //             : AxisDirection.right,
                    //         order: 4 + index,
                    //         orderDelay: 150,
                    //         duration: const Duration(milliseconds: 200),
                    //       ),
                    //     ),
                    //   ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
