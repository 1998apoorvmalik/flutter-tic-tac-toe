import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/board/widgets/widgets.dart';
import 'package:tic_tac_toe/board/board_index.dart';
import 'package:tic_tac_toe/board/cubit/board_cubit.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardCubit, BoardState>(
      listener: (context, state) {
        // print(state);
      },
      builder: (context, state) {
        List<BoardElement> board = [];

        for (int i = 0; i < state.board.length; i++) {
          for (int j = 0; j < state.board.length; j++) {
            board.add(
              BoardElement(
                boardElementType: state.board[i][j],
                onPressed: () => context
                    .read<BoardCubit>()
                    .playTurn(blockIndex: BoardIndex(row: i, col: j)),
              ),
            );
          }
        }

        return GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          crossAxisCount: state.board.length,
          children: board,
        );
      },
    );
  }
}
