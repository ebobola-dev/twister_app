import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/game/game_event.dart';
import 'package:twister_app/bloc/game/game_state.dart';
import 'package:twister_app/models/move/move.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? updateSecondsTimer;
  GameBloc() : super(GameNotStartedState()) {
    on<GameStartEvent>((event, emit) {
      if (state is GameNotStartedState) {
        emit(GameStartedState(
          livePlayers: event.players,
          deadPlayers: const [],
          movePlayer: event.players.first,
        ));

        updateSecondsTimer = Timer.periodic(
          const Duration(seconds: 1),
          (_) => add(GameIncrementSeconds()),
        );
      }
    });

    on<GameContinueGameEvent>((event, emit) {
      if (state is GameNotStartedState) {
        emit(GameStartedState(
          livePlayers: event.livePlayers,
          deadPlayers: event.deadPlayers,
          movePlayer: event.movePlayer,
          lastMovePlayer: event.moveLastPlayers,
          moves: event.moves,
          seconds: event.seconds,
        ));

        updateSecondsTimer = Timer.periodic(
          const Duration(seconds: 1),
          (_) => add(GameIncrementSeconds()),
        );
      }
    });

    on<GameRestartEvent>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        emit(GameStartedState(
          livePlayers: state_.livePlayers + state_.deadPlayers,
          deadPlayers: const [],
          movePlayer: state_.livePlayers.first,
        ));
        updateSecondsTimer?.cancel();
        updateSecondsTimer = Timer.periodic(
          const Duration(seconds: 1),
          (_) => add(GameIncrementSeconds()),
        );
      }
    });

    on<GameMoveEvent>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        emit(
          state_.copyWith(
            movePlayer: getNext(state_.livePlayers, state_.movePlayer),
            moves: state_.moves +
                [
                  Move(
                    player: state_.movePlayer,
                    part: event.part,
                    color: event.color,
                  ),
                ],
            lastMovePlayer: state_.movePlayer,
            updateLastMove: true,
          ),
        );
      }
    });

    on<GameMoveLastEvent>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        if (state_.lastMovePlayer == null) return;
        emit(
          state_.copyWith(
            moves: state_.moves +
                [
                  Move(
                    player: state_.lastMovePlayer!,
                    part: event.part,
                    color: event.color,
                  ),
                ],
          ),
        );
      }
    });

    on<GameRemovePlayerEvent>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        if (state_.livePlayers.length == 2) {
          emit(GameFinishedState(
            winner: state_.livePlayers
                .where((element) => element != event.player)
                .first,
            seconds: state_.seconds,
            players: state_.livePlayers + state_.deadPlayers,
            moves: state_.moves,
          ));
          updateSecondsTimer?.cancel();
        } else {
          String? lastPlayer = state_.lastMovePlayer;
          String nowPlayer = state_.movePlayer;
          if (event.player == lastPlayer) {
            lastPlayer = null;
          }
          if (event.player == nowPlayer) {
            nowPlayer = getNext(state_.livePlayers, nowPlayer);
          }
          emit(
            state_.copyWith(
              livePlayers: state_.livePlayers
                  .where((element) => element != event.player)
                  .toList(),
              deadPlayers: state_.deadPlayers + [event.player],
              movePlayer: nowPlayer,
              lastMovePlayer: lastPlayer,
              updateLastMove: true,
            ),
          );
        }
      }
    });

    on<GameFinishEvent>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        emit(GameFinishedState(
          winner: event.winner,
          seconds: state_.seconds,
          players: state_.livePlayers + state_.deadPlayers,
          moves: state_.moves,
        ));
        updateSecondsTimer?.cancel();
      }
    });

    on<GameSaveEvent>((event, emit) {
      if (state is GameStartedState) {
        //TODO SAVE STARTED GAME
        emit(GameNotStartedState());
        updateSecondsTimer?.cancel();
      } else if (state is GameFinishedState) {
        //TODO SAVE FINISHED GAME
        emit(GameNotStartedState());
      }
    });

    on<GameIncrementSeconds>((event, emit) {
      if (state is GameStartedState) {
        final state_ = state as GameStartedState;
        emit(state_.copyWith(seconds: state_.seconds + 1));
      }
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
