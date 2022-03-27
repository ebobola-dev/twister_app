import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/fortune/fortune_event.dart';
import 'package:twister_app/bloc/fortune/fortune_state.dart';

class FortuneBloc extends Bloc<FortuneEvent, FortuneState> {
  FortuneBloc() : super(FortuneStartState()) {
    on<FortuneSetStartEvent>((event, emit) {
      emit(FortuneStartState());
    });

    on<FortuneSpinEvent>((event, emit) {
      emit(event.current
          ? FortuneSpinnigCurrentState()
          : FortuneSpinnigLastState());
    });

    on<FortuneChoiceEvent>((event, emit) {
      emit(FortuneChosenState(event.player, event.part, event.color));
    });
  }
}
