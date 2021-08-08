part of 'game_controller_cubit.dart';

class GameControllerState extends Equatable {
  const GameControllerState({
    required this.boardSize,
    required this.gameType,
    required this.aiDifficulty,
  });

  factory GameControllerState.initial() => const GameControllerState(
        boardSize: 3,
        gameType: GameType.playWithFriend,
        aiDifficulty: AiDifficulty.easy,
      );

  final int boardSize;
  final GameType gameType;
  final AiDifficulty aiDifficulty;

  @override
  List<Object> get props => [boardSize, gameType, aiDifficulty];

  GameControllerState copyWith({
    int? boardSize,
    GameType? gameType,
    AiDifficulty? aiDifficulty,
  }) {
    return GameControllerState(
      boardSize: boardSize ?? this.boardSize,
      gameType: gameType ?? this.gameType,
      aiDifficulty: aiDifficulty ?? this.aiDifficulty,
    );
  }
}
