import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polindrome/input/bloc/input_bloc.dart';
import 'package:flutter_polindrome/input/bloc/input_event.dart';
import 'package:flutter_polindrome/input/bloc/input_state.dart';
import 'package:flutter_polindrome/input_model.dart';
import 'package:flutter_polindrome/result/result_screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late InputBloc _bloc;
  final bool _isPalindrome = true;

  @override
  void initState() {
    _bloc = InputBloc();
    super.initState();
  }

  void _mapState(InputState state) {
    if (state is PalindromeChecked) {
      Future.microtask(() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                param: InputModel(
                    input: _controller.text, isPalindrome: state.isPalindrome),
              ),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<InputBloc, InputState>(
        builder: (BuildContext context, InputState state) {
          _mapState(state);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Palindrome Checker"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Input String"),
                TextField(
                  controller: _controller,
                ),
                GestureDetector(
                  onTap: () {
                    _bloc.add(CheckPalindrome(input: _controller.text));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
