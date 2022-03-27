import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/add_player/add_player_event.dart';
import 'package:twister_app/bloc/add_player/add_player_state.dart';

class AddPlayerBloc extends Bloc<AddPlayerEvent, AddPlayerState> {
  AddPlayerBloc() : super(const AddPlayerState()) {
    on<AddPlayerChangeEvent>(((event, emit) {
      emit(AddPlayerState(text: event.newText));
    }));

    on<AddPlayerClearEvent>(((event, emit) {
      emit(const AddPlayerState());
    }));
  }
}
