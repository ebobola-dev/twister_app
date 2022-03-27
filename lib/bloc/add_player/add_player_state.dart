import 'package:equatable/equatable.dart';

class AddPlayerState extends Equatable {
  final String text;
  const AddPlayerState({this.text = ''});

  @override
  List<Object> get props => [text];
}
