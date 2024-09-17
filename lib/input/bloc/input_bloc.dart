import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polindrome/input/bloc/input_event.dart';
import 'package:flutter_polindrome/input/bloc/input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(InputState()) {
    on<CheckPalindrome>((event, emit) {
      final input = event.input.toLowerCase();
      final reversed = input.split('').reversed.join();
      bool isPalindrome = input == reversed;
      emit(PalindromeChecked(isPalindrome: isPalindrome));
    });
  }
}
