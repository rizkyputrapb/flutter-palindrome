import 'package:equatable/equatable.dart';
import 'package:flutter_polindrome/input_model.dart';

class ResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveInput extends ResultEvent {
  final InputModel input;

  SaveInput({required this.input});

  @override
  List<Object?> get props => [input];
}

class FetchResults extends ResultEvent {}

class DeleteResults extends ResultEvent {
  int id;

  DeleteResults({required this.id});

  @override
  List<Object?> get props => [id];
}
