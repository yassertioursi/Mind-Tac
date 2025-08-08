import 'package:flutter/material.dart';
import 'package:mindtac/utils/app_colors.dart';
import 'package:mindtac/domain/models/game_model.dart';

class GameBoard extends StatelessWidget {
  final List<String> board;
  final void Function(int index)? onTap;

  const GameBoard({
    Key? key,
    required this.board,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width;

    return Container(
      width: boardSize,
      height: boardSize,
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: Game.boardlenth,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final value = board[index];
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: AppColors.tileColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  )
                ],
                border: Border.all(
                  color: value == "X" ? AppColors.xColor : AppColors.oColor,
                  width: value.isEmpty ? 0 : 2,
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Text(
                    value,
                    key: ValueKey(value),
                    style: TextStyle(
                      fontSize: boardSize * 0.15,
                      fontWeight: FontWeight.w900,
                      color: value == "X"
                          ? AppColors.xColor
                          : AppColors.oColor,
                      shadows: const [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
