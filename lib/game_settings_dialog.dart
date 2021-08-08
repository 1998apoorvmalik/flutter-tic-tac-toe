import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/game_controller_cubit.dart';
import 'package:tic_tac_toe/enums.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class GameSettingsDialog extends StatelessWidget {
  const GameSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _radioFunction(int? val) {
      context.read<GameControllerCubit>().applySettings(boardSize: val);
    }

    void _firstMoveFunction(GameType? gameType) {
      context.read<GameControllerCubit>().applySettings(gameType: gameType);
    }

    return AlertDialog(
      title: Column(
        children: const <Widget>[
          Text(
            'Game Settings',
            style: TextStyle(fontSize: 24),
          ),
          Divider()
        ],
      ),
      content: BlocBuilder<GameControllerCubit, GameControllerState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Board Size',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('3x3'),
                      Radio<int>(
                        value: 3,
                        groupValue: state.boardSize,
                        onChanged: _radioFunction,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('4x4'),
                      Radio<int>(
                        value: 4,
                        groupValue: state.boardSize,
                        onChanged: _radioFunction,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('5x5'),
                      Radio<int>(
                        value: 5,
                        groupValue: state.boardSize,
                        onChanged: _radioFunction,
                      ),
                    ],
                  ),
                ],
              ),
              if (state.gameType != GameType.playWithFriend)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Who Goes First?',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('Human'),
                            Radio<GameType>(
                              value: GameType.playWithComputerGoesSeconds,
                              groupValue: state.gameType,
                              onChanged: _firstMoveFunction,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Computer'),
                            Radio<GameType>(
                              value: GameType.playWithComputerGoesFirst,
                              groupValue: state.gameType,
                              onChanged: _firstMoveFunction,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
            ],
          );
        },
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((Route<dynamic> route) => route.isFirst);
                Navigator.of(context).push(GameScreen.route());
              },
              child: const Text('Play'),
            ),
          ],
        )
      ],
    );
  }
}
