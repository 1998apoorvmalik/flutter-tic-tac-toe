import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/agents/random_agent.dart';
import 'package:tic_tac_toe/board/board_index.dart';
import 'package:tic_tac_toe/board/cubit/board_cubit.dart';
import 'package:tic_tac_toe/board/widgets/widgets.dart';
import 'package:tic_tac_toe/cubit/game_controller_cubit.dart';
import 'package:tic_tac_toe/enums.dart';
import 'package:tic_tac_toe/game_settings_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  static Route route() => PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            BlocProvider<BoardCubit>(
                create: (context) => BoardCubit(), child: const GameScreen()),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    context.read<BoardCubit>().changeBoardSize(
        newSize: context.read<GameControllerCubit>().state.boardSize);

    void _checkComputerTurn(BoardState state) {
      final GameControllerState _gameControllerState =
          context.read<GameControllerCubit>().state;
      void _computerPlayTurn() async {
        final BoardIndex boardIndex = await RandomAgent.playMove(state);
        context.read<BoardCubit>().playTurn(blockIndex: boardIndex);
      }

      switch (_gameControllerState.gameType) {
        case GameType.playWithComputerGoesFirst:
          if (state.gameStatus == GameStatus.crossTurn) {
            _computerPlayTurn();
          }
          break;
        case GameType.playWithComputerGoesSeconds:
          if (state.gameStatus == GameStatus.circleTurn) {
            _computerPlayTurn();
          }
          break;
        case GameType.playWithFriend:
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            onPressed: () => context.read<BoardCubit>().reset(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const GameSettingsDialog(),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          String _statusMessage;
          List<BoardElement> board = [];

          switch (state.gameStatus) {
            case GameStatus.crossTurn:
              _statusMessage = 'Cross Turn';
              break;
            case GameStatus.circleTurn:
              _statusMessage = 'Circle Turn';
              break;
            case GameStatus.crossWinner:
              _statusMessage = 'Cross Winner!';
              break;
            case GameStatus.circleWinner:
              _statusMessage = 'Circle Winner!';
              break;
            case GameStatus.tied:
              _statusMessage = 'Game Tied!';
              break;
          }

          for (int i = 0; i < state.board.length; i++) {
            for (int j = 0; j < state.board.length; j++) {
              board.add(
                BoardElement(
                  boardElementType: state.board[i][j],
                  onPressed: () {
                    final GameControllerState _gameControllerState =
                        context.read<GameControllerCubit>().state;

                    void _playTurn() => context
                        .read<BoardCubit>()
                        .playTurn(blockIndex: BoardIndex(row: i, col: j));

                    switch (_gameControllerState.gameType) {
                      case GameType.playWithComputerGoesFirst:
                        if (state.gameStatus != GameStatus.crossTurn) {
                          _playTurn();
                        }
                        break;
                      case GameType.playWithComputerGoesSeconds:
                        if (state.gameStatus != GameStatus.circleTurn) {
                          _playTurn();
                        }
                        break;
                      case GameType.playWithFriend:
                        _playTurn();
                        break;
                    }
                  },
                  boardSize: state.board.length,
                ),
              );
            }
          }

          _checkComputerTurn(state);

          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      _statusMessage,
                      style: const TextStyle(
                          fontSize: 28, color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                    ),
                    if (state.gameStatus != GameStatus.circleTurn &&
                        state.gameStatus != GameStatus.crossTurn)
                      TextButton(
                        onPressed: () => context.read<BoardCubit>().nextGame(),
                        child: const Text('Play Next'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  crossAxisCount: state.board.length,
                  children: board,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WINS',
                      style: TextStyle(fontSize: 32),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.close,
                              size: 50,
                              color: Colors.deepOrangeAccent,
                            ),
                            Text(
                              state.crossWins.toString(),
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.circle_outlined,
                                size: 42,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            Text(
                              state.circleWins.toString(),
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
