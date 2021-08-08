enum BoardElementType {
  empty,
  cross,
  circle,
}

enum GameStatus {
  crossTurn,
  circleTurn,
  crossWinner,
  circleWinner,
  tied,
}

enum GameType {
  playWithComputerGoesFirst,
  playWithComputerGoesSeconds,
  playWithFriend,
}

enum AiDifficulty {
  easy,
  medium,
  hard,
}
