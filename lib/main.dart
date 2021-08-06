import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/board/board.dart';
import 'package:tic_tac_toe/board/cubit/board_cubit.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: TicTacToe(),
        ),
      ),
    ),
  );
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BoardCubit>(
      create: (context) => BoardCubit(),
      child: Center(
        child: BlocConsumer<BoardCubit, BoardState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Board(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        state.gameStatus.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: () => context.read<BoardCubit>().reset(),
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
