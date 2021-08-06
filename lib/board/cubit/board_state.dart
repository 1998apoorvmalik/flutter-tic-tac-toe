part of 'board_cubit.dart';

class BoardState extends Equatable {
  const BoardState(
      {required this.board,
      required this.validMoves,
      required this.gameStatus});

  factory BoardState.initial({required int size}) {
    final List<List<BoardElementType>> board = Helper.generateBoard(size: size);
    final List<BoardIndex> validMoves = Helper.getValidMoves(board: board);
    return BoardState(
        board: board, validMoves: validMoves, gameStatus: GameStatus.crossTurn);
  }

  final List<List<BoardElementType>> board;
  final List<BoardIndex> validMoves;
  final GameStatus gameStatus;

  @override
  List<Object> get props => [board, validMoves, gameStatus];

  BoardState copyWith({
    List<List<BoardElementType>>? board,
    List<BoardIndex>? validMoves,
    GameStatus? gameStatus,
  }) {
    return BoardState(
      board: board ?? this.board,
      validMoves: validMoves ?? this.validMoves,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}
