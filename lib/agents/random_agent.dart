import 'dart:math';

import 'package:tic_tac_toe/board/board_index.dart';
import 'package:tic_tac_toe/board/cubit/board_cubit.dart';
import 'package:tic_tac_toe/constants.dart';

class RandomAgent {
  static Future<BoardIndex> playMove(BoardState boardState) async {
    await Future.delayed(kRandomAgentThinkDuration);
    final Random random = Random();
    return boardState.validMoves
        .elementAt(random.nextInt(boardState.validMoves.length));
  }
}
