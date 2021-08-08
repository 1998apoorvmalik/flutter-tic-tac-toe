part of 'board_cubit.dart';

class BoardState extends Equatable {
  const BoardState({
    required this.board,
    required this.validMoves,
    required this.gameStatus,
    required this.crossWins,
    required this.circleWins,
  });

  factory BoardState.initial({required int size}) {
    final List<List<BoardElementType>> board = Helper.generateBoard(size: size);
    final List<BoardIndex> validMoves = Helper.getValidMoves(board: board);
    return BoardState(
      board: board,
      validMoves: validMoves,
      gameStatus: GameStatus.crossTurn,
      crossWins: 0,
      circleWins: 0,
    );
  }

  final List<List<BoardElementType>> board;
  final List<BoardIndex> validMoves;
  final GameStatus gameStatus;
  final int crossWins;
  final int circleWins;

  @override
  List<Object> get props => [board, validMoves, gameStatus];

  BoardState copyWith({
    List<List<BoardElementType>>? board,
    List<BoardIndex>? validMoves,
    GameStatus? gameStatus,
    int? crossWins,
    int? circleWins,
  }) {
    return BoardState(
      board: board ?? this.board,
      validMoves: validMoves ?? this.validMoves,
      gameStatus: gameStatus ?? this.gameStatus,
      crossWins: crossWins ?? this.crossWins,
      circleWins: circleWins ?? this.circleWins,
    );
  }
}
