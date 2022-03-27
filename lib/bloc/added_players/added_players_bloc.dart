import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/added_players/added_players_event.dart';
import 'package:twister_app/bloc/added_players/added_players_state.dart';

class AddedPlayersBloc extends Bloc<AddedPlayersEvent, AddedPlayersState> {
  AddedPlayersBloc() : super(const AddedPlayersState([])) {
    on<AddedPlayersAddEvent>((event, emit) {
      if (state.players.length < 6) {
        emit(state.copyWith(event.name));
      }
    });
    on<AddedPlayersRemoveEvent>((event, emit) {
      emit(state.copyWithout(event.name));
    });
    on<AddedPlayersClearEvent>((event, emit) {
      emit(const AddedPlayersState([]));
    });
  }
}
