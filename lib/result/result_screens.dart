import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polindrome/input_model.dart';
import 'package:flutter_polindrome/result/bloc/result_bloc.dart';
import 'package:flutter_polindrome/result/bloc/result_event.dart';
import 'package:flutter_polindrome/result/bloc/result_state.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key, required this.param});

  InputModel param;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late InputModel _param;
  List<InputModel>? _resultList;
  final ResultBloc _bloc = ResultBloc();

  @override
  void initState() {
    _param = widget.param;
    super.initState();
  }

  void _mapState(ResultState state) {
    if (state is ResultSaved || state is ResultDeleted) {
      _bloc.add(FetchResults());
    }

    if (state is ResultLoaded) {
      _resultList = state.listResults;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc..add(FetchResults()),
      child: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          _mapState(state);
          return Scaffold(
            appBar: AppBar(
              title: Text(_param.input!),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Hasil dari input:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(_param.input!),
                      ),
                      GestureDetector(
                        onTap: () => _bloc.add(SaveInput(input: _param)),
                        child: Container(
                          color: Colors.amber,
                          child: const Text("Submit"),
                        ),
                      )
                    ],
                  ),
                  Text(
                      "Input ${_param.isPalindrome! ? '' : 'bukan'} merupakan kalimat palindrome"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _resultList?.length ?? 0,
                    itemBuilder: (context, idx) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_resultList![idx].id.toString()),
                        Text(_resultList![idx].input!),
                        Text(_resultList![idx].isPalindrome ?? false
                            ? 'Palindrome'
                            : 'Bukan Palindrome'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
