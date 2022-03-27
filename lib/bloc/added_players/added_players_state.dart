import 'package:equatable/equatable.dart';

class AddedPlayersState extends Equatable {
  final List<String> players;
  const AddedPlayersState(this.players);

  @override
  List<Object> get props => [players];

  AddedPlayersState copyWith(String newPlayer) => AddedPlayersState(
        players + [newPlayer],
      );

  AddedPlayersState copyWithout(String player) => AddedPlayersState(
        players.where((element) => element != player).toList(),
      );
}
