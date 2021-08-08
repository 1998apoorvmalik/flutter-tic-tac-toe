import 'package:tic_tac_toe/board/board_index.dart';
import 'package:tic_tac_toe/enums.dart';
import 'package:tuple/tuple.dart';

class Helper {
  static List<List<BoardElementType>> generateBoard({required int size}) {
    List<List<BoardElementType>> board = [];
    for (int i = 0; i < size; i++) {
      List<BoardElementType> row = [];
      for (int j = 0; j < size; j++) {
        row.add(BoardElementType.empty);
      }
      board.add(row);
    }
    return board;
  }

  static List<BoardIndex> getValidMoves(
      {required List<List<BoardElementType>> board}) {
    List<BoardIndex> validMoves = [];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (board[i][j] == BoardElementType.empty) {
          validMoves.add(BoardIndex(row: i, col: j));
        }
      }
    }
    return validMoves;
  }

  static bool isGameEnded({required GameStatus gameStatus}) {
    return (gameStatus == GameStatus.crossWinner ||
        gameStatus == GameStatus.circleWinner ||
        gameStatus == GameStatus.tied);
  }

  static bool isGameWon({required List<List<BoardElementType>> board}) {
    final Tuple2<int, int> bottomLeftIndex =
        Tuple2<int, int>(board.length - 1, 0);
    Tuple2<int, int> topLeftIndex = const Tuple2<int, int>(0, 0);

    // Check top left diagonal path.
    if (_checkIfBoardPathCompleted(
      board: board,
      startBlockIndex: topLeftIndex,
      direction: const Tuple2(1, 1),
    )) {
      return true;
    }

    // Check bottom left diagonal path.
    if (_checkIfBoardPathCompleted(
      board: board,
      startBlockIndex: bottomLeftIndex,
      direction: const Tuple2(-1, 1),
    )) {
      return true;
    }

    for (int i = 0; i < board.length; i++) {
      // Check all row paths.
      if (_checkIfBoardPathCompleted(
        board: board,
        startBlockIndex:
            Tuple2<int, int>(topLeftIndex.item1 + i, topLeftIndex.item2),
        direction: const Tuple2(0, 1),
      )) {
        return true;
      }

      // Check all column paths.
      if (_checkIfBoardPathCompleted(
        board: board,
        startBlockIndex:
            Tuple2<int, int>(bottomLeftIndex.item1, bottomLeftIndex.item2 + i),
        direction: const Tuple2(-1, 0),
      )) {
        return true;
      }
    }

    return false;
  }

  static _isSafe(Tuple2<int, int> index, int boardSize) =>
      index.item1 > -1 &&
      index.item2 > -1 &&
      index.item1 < boardSize &&
      index.item2 < boardSize;

  static bool _checkIfBoardPathCompleted(
      {required List<List<BoardElementType>> board,
      required Tuple2<int, int> startBlockIndex,
      required Tuple2<int, int> direction}) {
    Tuple2<int, int> _indexIterator;
    BoardElementType _refBoardElementType;

    _indexIterator = startBlockIndex;
    _refBoardElementType = board[startBlockIndex.item1][startBlockIndex.item2];

    if (_refBoardElementType == BoardElementType.empty) {
      return false;
    }

    int _pathLength = 1;
    while (true) {
      _refBoardElementType = board[_indexIterator.item1][_indexIterator.item2];

      Tuple2<int, int> _nextIndex = Tuple2<int, int>(
          _indexIterator.item1 + direction.item1,
          _indexIterator.item2 + direction.item2);

      if (_isSafe(_nextIndex, board.length)) {
        _indexIterator = _nextIndex;
        _refBoardElementType =
            board[_indexIterator.item1][_indexIterator.item2];

        if (_refBoardElementType !=
            board[startBlockIndex.item1][startBlockIndex.item2]) {
          return false;
        }

        _pathLength++;
      } else {
        break;
      }
    }
    return _pathLength == board.length;
  }
}
