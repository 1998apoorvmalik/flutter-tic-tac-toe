import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/board/board_index.dart';
import 'package:tic_tac_toe/enums.dart';
import 'package:tic_tac_toe/helper/helper.dart';
import 'package:tic_tac_toe/constants.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardState.initial(size: DEFAULT_BOARD_SIZE));

  void reset() {
    emit(BoardState.initial(size: DEFAULT_BOARD_SIZE));
  }

  void playTurn({required BoardIndex blockIndex}) {
    if (state.gameStatus != GameStatus.circleWinner &&
        state.gameStatus != GameStatus.crossWinner &&
        state.board[blockIndex.row][blockIndex.col] == BoardElementType.empty) {
      List<List<BoardElementType>> newBoard = state.board;

      GameStatus newStatus;
      if (state.gameStatus == GameStatus.crossTurn) {
        newBoard[blockIndex.row][blockIndex.col] = BoardElementType.cross;
        newStatus = GameStatus.circleTurn;
      } else {
        newBoard[blockIndex.row][blockIndex.col] = BoardElementType.circle;
        newStatus = GameStatus.crossTurn;
      }

      List<BoardIndex> validMoves = Helper.getValidMoves(board: newBoard);

      if (Helper.isGameWon(board: newBoard)) {
        emit(
          BoardState(
            board: newBoard,
            validMoves: validMoves,
            gameStatus: state.gameStatus == GameStatus.crossTurn
                ? GameStatus.crossWinner
                : GameStatus.circleWinner,
          ),
        );
        return;
      }

      emit(state.copyWith(
          board: newBoard,
          validMoves: validMoves,
          gameStatus: validMoves.length > 0 ? newStatus : GameStatus.tied));
    }
  }
}
