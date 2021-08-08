import 'package:equatable/equatable.dart';

class BoardIndex extends Equatable {
  const BoardIndex({required this.row, required this.col});

  final int row;
  final int col;

  @override
  List<Object?> get props => [row, col];
}
