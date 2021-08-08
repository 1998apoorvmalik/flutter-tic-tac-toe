import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/game_controller_cubit.dart';
import 'package:tic_tac_toe/enums.dart';
import 'package:tic_tac_toe/game_settings_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const double contentVerticalPaddingAmount = 12;

  @override
  Widget build(BuildContext context) {
    final buttonHorizontalPaddingAmount = MediaQuery.of(context).size.width / 4;

    return BlocConsumer<GameControllerCubit, GameControllerState>(
      listener: (context, state) {},
      builder: (BuildContext context, GameControllerState state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tic Tac Toe',
                style: TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: contentVerticalPaddingAmount * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: contentVerticalPaddingAmount,
                    horizontal: buttonHorizontalPaddingAmount),
                child: TextButton(
                  onPressed: () {
                    context
                        .read<GameControllerCubit>()
                        .gameTypeChanged(GameType.playWithFriend);

                    showDialog(
                        context: context,
                        builder: (_) => const GameSettingsDialog());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.0),
                    child: Text(
                      'Play with Friend',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: contentVerticalPaddingAmount,
                    horizontal: buttonHorizontalPaddingAmount),
                child: TextButton(
                  onPressed: () {
                    context
                        .read<GameControllerCubit>()
                        .gameTypeChanged(GameType.playWithComputerGoesFirst);

                    showDialog(
                        context: context,
                        builder: (_) => const GameSettingsDialog());
                  },
                  child: const Text(
                    'Play with Computer',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
