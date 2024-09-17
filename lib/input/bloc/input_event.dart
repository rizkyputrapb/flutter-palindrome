import 'package:equatable/equatable.dart';

class InputEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckPalindrome extends InputEvent{
  final String input;

  CheckPalindrome({required this.input});

  @override
  List<Object?> get props => [input];
}