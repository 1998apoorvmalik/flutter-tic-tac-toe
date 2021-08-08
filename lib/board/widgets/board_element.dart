import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/enums.dart';

class BoardElement extends StatelessWidget {
  const BoardElement({
    Key? key,
    required this.boardSize,
    required this.onPressed,
    required this.boardElementType,
  }) : super(key: key);

  final int boardSize;
  final VoidCallback onPressed;
  final BoardElementType boardElementType;

  @override
  Widget build(BuildContext context) {
    final IconData elementIcon;

    switch (boardElementType) {
      case BoardElementType.empty:
        elementIcon = const IconData(0);
        break;
      case BoardElementType.cross:
        elementIcon = Icons.close;
        break;
      case BoardElementType.circle:
        elementIcon = Icons.circle_outlined;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Center(
          child: Icon(elementIcon,
              size: MediaQuery.of(context).size.width / (boardSize + 3)),
        ),
      ),
    );
  }
}
