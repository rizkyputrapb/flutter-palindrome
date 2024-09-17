import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polindrome/database.dart';
import 'package:flutter_polindrome/input_model.dart';
import 'package:flutter_polindrome/result/bloc/result_event.dart';
import 'package:flutter_polindrome/result/bloc/result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultState()) {
    on<FetchResults>((event, emit) async {
      List<InputModel>? results = await PalindromeDatabase.instance.read();
      emit(ResultLoaded(listResults: results));
    });
    on<DeleteResults>((event, emit) {});
    on<SaveInput>((event, emit) async {
      try {
        await PalindromeDatabase.instance.create(event.input);
        emit(ResultSaved());
      } catch (e) {
        print('error saving');
      }
    });
  }
}
