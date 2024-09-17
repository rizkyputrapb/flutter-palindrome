import 'package:equatable/equatable.dart';

class InputState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PalindromeChecked extends InputState {
  bool isPalindrome;

  PalindromeChecked({required this.isPalindrome});

  @override
  List<Object?> get props => [isPalindrome];
}
