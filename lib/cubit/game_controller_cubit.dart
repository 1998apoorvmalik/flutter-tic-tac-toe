import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/enums.dart';

part 'game_controller_state.dart';

class GameControllerCubit extends Cubit<GameControllerState> {
  GameControllerCubit() : super(GameControllerState.initial());

  void gameTypeChanged(GameType gameType) {
    emit(
      state.copyWith(
        gameType: gameType,
      ),
    );
  }

  void applySettings(
      {int? boardSize, GameType? gameType, AiDifficulty? aiDifficulty}) {
    emit(
      state.copyWith(
        boardSize: boardSize,
        gameType: gameType,
        aiDifficulty: aiDifficulty,
      ),
    );
  }
}
