import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/models/move/move.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? updateSecondsTimer;

  GameBloc({List<String>? players, GameState? oldState})
      : assert((players != null && oldState == null) ||
            (players == null && oldState != null)),
        super(oldState ??
            GameState(
              millisecondsSinceEpoch: DateTime.now().millisecondsSinceEpoch,
              livePlayers: players!,
              deadPlayers: const [],
              movePlayer: players.first,
            )) {
    updateSecondsTimer?.cancel();
    updateSecondsTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(GameIncrementSecondsEvent()),
    );

    on<GameRestartEvent>((event, emit) {
      emit(GameState(
        millisecondsSinceEpoch: state.millisecondsSinceEpoch,
        livePlayers: state.livePlayers + state.deadPlayers,
        deadPlayers: const [],
        movePlayer: state.livePlayers.first,
      )..save_());
      updateSecondsTimer?.cancel();
      updateSecondsTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => add(GameIncrementSecondsEvent()),
      );
    });

    on<GameMoveEvent>((event, emit) {
      emit(
        state.copyWith(
          movePlayer: getNext(state.livePlayers, state.movePlayer),
          moves: state.moves +
              [
                Move(
                  player: state.movePlayer,
                  part: event.part,
                  color: event.color,
                ),
              ],
          lastMovePlayer: state.movePlayer,
          updateLastMove: true,
        )..save_(),
      );
    });

    on<GameMoveLastEvent>((event, emit) {
      if (state.lastMovePlayer == null) return;
      emit(
        state.copyWith(
          moves: state.moves +
              [
                Move(
                  player: state.lastMovePlayer!,
                  part: event.part,
                  color: event.color,
                ),
              ],
        )..save_(),
      );
    });

    on<GameRemovePlayerEvent>((event, emit) {
      if (state.livePlayers.length == 2) {
        emit(state.win(
            state.livePlayers.where((element) => element != event.player).first)
          ..save_());
        updateSecondsTimer?.cancel();
      } else {
        String? lastPlayer = state.lastMovePlayer;
        String nowPlayer = state.movePlayer;
        if (event.player == lastPlayer) {
          lastPlayer = null;
        }
        if (event.player == nowPlayer) {
          nowPlayer = getNext(state.livePlayers, nowPlayer);
        }
        emit(
          state.copyWith(
            livePlayers: state.livePlayers
                .where((element) => element != event.player)
                .toList(),
            deadPlayers: state.deadPlayers + [event.player],
            movePlayer: nowPlayer,
            lastMovePlayer: lastPlayer,
            updateLastMove: true,
          )..save_(),
        );
      }
    });

    on<GameFinishEvent>((event, emit) {
      emit(state.win(event.winner)..save_());
      updateSecondsTimer?.cancel();
    });

    on<GameIncrementSecondsEvent>((event, emit) {
      emit(state.copyWith(seconds: state.seconds + 1)..save_());
    });

    on<GameStopTimerEvent>((event, emit) {
      updateSecondsTimer?.cancel();
    });
  }

  String getPrevious(List<String> players, String current) {
    final currentIndex = players.indexOf(current);
    if (currentIndex == 0) {
      return players.last;
    } else {
      return players[currentIndex - 1];
    }
  }

  String getNext(List<String> players, String current) {
    final currentIndex = players.indexOf(current);
    if (currentIndex == players.length - 1) {
      return players.first;
    } else {
      return players[currentIndex + 1];
    }
  }
}
