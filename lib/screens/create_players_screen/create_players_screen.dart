import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/widgets/animations/fade_animation.dart';
import 'package:twister_app/bloc/add_player/add_player_bloc.dart';
import 'package:twister_app/bloc/add_player/add_player_event.dart';
import 'package:twister_app/bloc/added_players/added_players_bloc.dart';
import 'package:twister_app/bloc/added_players/added_players_event.dart';
import 'package:twister_app/bloc/added_players/added_players_state.dart';
import 'package:twister_app/models/move/move_enums.dart';
import 'package:twister_app/widgets/cards/player_chip.dart';
import 'package:twister_app/screens/game_screen/game_screen.dart';
import 'package:twister_app/ui_funcs.dart';
import 'package:twister_app/widgets/header/simple_header.dart';

class CreatePlayersScreen extends StatelessWidget {
  CreatePlayersScreen({Key? key}) : super(key: key);

  final TextEditingController _addPlayerField = TextEditingController();

  void addPlayer(BuildContext context) {
    final addedPlayersBloc = context.read<AddedPlayersBloc>();
    final addPlayerBloc = context.read<AddPlayerBloc>();
    final players = addedPlayersBloc.state.players;
    if (_addPlayerField.text.isNotEmpty && players.length < 6) {
      if (players.contains(_addPlayerField.text)) {
        return showSimpleWarning(
            context, '"${_addPlayerField.text}" уже добавлен(а)');
      }
      addedPlayersBloc.add(
        AddedPlayersAddEvent(_addPlayerField.text),
      );
      _addPlayerField.clear();
      addPlayerBloc.add(AddPlayerClearEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final addPlayerBloc = context.read<AddPlayerBloc>();
      final addedPlayersBloc = context.read<AddedPlayersBloc>();
      _addPlayerField.text = addPlayerBloc.state.text;
      return ThemeSwitchingArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SimpleHeader(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const FaIcon(FontAwesomeIcons.arrowLeftLong),
              ),
              title: const Text("ДОБАВЬТЕ ИГРОКОВ"),
              fadeDuration: const Duration(milliseconds: 200),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimation(
                  from: AxisDirection.up,
                  duration: const Duration(milliseconds: 300),
                  order: 2,
                  child: TextField(
                    controller: _addPlayerField,
                    decoration: InputDecoration(
                      labelText: "Введите имя игрока",
                      suffix: GestureDetector(
                        onTap: () {
                          _addPlayerField.clear();
                          addPlayerBloc.add(AddPlayerClearEvent());
                        },
                        child: const FaIcon(FontAwesomeIcons.deleteLeft),
                      ),
                    ),
                    onEditingComplete: () => addPlayer(context),
                    onChanged: (newText) =>
                        addPlayerBloc.add(AddPlayerChangeEvent(newText)),
                  ),
                ),
                const SizedBox(height: 20),
                FadeAnimation(
                  from: AxisDirection.up,
                  duration: const Duration(milliseconds: 300),
                  order: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AddedPlayersBloc, AddedPlayersState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.players.length < 6
                              ? () => addPlayer(context)
                              : null,
                          child: const Text("Добавить"),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  from: AxisDirection.up,
                  duration: const Duration(milliseconds: 300),
                  order: 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AddedPlayersBloc, AddedPlayersState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.players.length > 1
                              ? () {
                                  context
                                      .read<GameBloc>()
                                      .add(GameStartEvent(state.players));
                                  animatedSwitchPage(
                                    context,
                                    const GameScreen(),
                                    routeAnimation: RouteAnimation.slideBottom,
                                    withBack: false,
                                    clearNavigator: true,
                                  );
                                }
                              : null,
                          child: const Text("Начать игру"),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  from: AxisDirection.up,
                  duration: const Duration(milliseconds: 300),
                  order: 5,
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AddedPlayersBloc, AddedPlayersState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.players.isNotEmpty
                              ? () =>
                                  addedPlayersBloc.add(AddedPlayersClearEvent())
                              : null,
                          child: const Text("Отчистить список игроков"),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeAnimation(
                  from: AxisDirection.down,
                  duration: const Duration(milliseconds: 300),
                  order: 6,
                  child: BlocBuilder<AddedPlayersBloc, AddedPlayersState>(
                    builder: (context, state) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          state.players.length,
                          (index) => PlayerChip(
                            player: state.players[index],
                            deleteColor: moveColors[index % 4],
                            onDelete: (player) => context
                                .read<AddedPlayersBloc>()
                                .add(AddedPlayersRemoveEvent(player)),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

//return Chip(
//   label: Text(state.players[index]),
//   deleteIcon: const FaIcon(
//     FontAwesomeIcons.circleMinus,
//   ),
//   elevation: 3,
//   onDeleted: () => addedPlayersBloc.add(
//     AddedPlayersRemoveEvent(state.players[index]),
//   ),
//   deleteIconColor: chipColor,
//   // backgroundColor: chipColor,
// );