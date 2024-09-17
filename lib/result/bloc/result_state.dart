import 'package:equatable/equatable.dart';
import 'package:flutter_polindrome/input_model.dart';

class ResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultLoaded extends ResultState {
  List<InputModel>? listResults;

  ResultLoaded({required this.listResults});

  @override
  List<Object?> get props => [listResults];
}

class ResultDeleted extends ResultState {}

class ResultSaved extends ResultState {}
