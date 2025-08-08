import 'package:flutter/material.dart';
import 'package:mindtac/domain/models/game_model.dart';
import 'package:mindtac/presentation/widgets/game_board.dart';
import 'package:mindtac/utils/app_colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = List.filled(8, 0);
  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
  }

  void _handleTap(int index) {
    if (game.board![index] == "") {
      setState(() {
        game.board![index] = lastValue;
        turn++;
        gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
        if (gameOver) {
          result = "$lastValue wins!";
        } else if (turn == 9) {
          gameOver = true;
          result = "Draw!";
        }
        lastValue = lastValue == "X" ? "O" : "X";
      });
    }
  }

  void _resetGame() {
    setState(() {
      game.board = Game.initGameBoard();
      lastValue = "X";
      gameOver = false;
      turn = 0;
      result = "";
      scoreboard = List.filled(8, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MindTac",
                style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                gameOver ? result : "Turn: $lastValue",
                style: TextStyle(
                  fontSize: width * 0.06,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GameBoard(board: game.board!, onTap: gameOver ? null : _handleTap),
              InkWell(
  onTap: _resetGame,
  borderRadius: BorderRadius.circular(20),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.accentColor.withOpacity(0.9), AppColors.secondaryColor.withOpacity(0.9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.accentColor.withOpacity(0.6),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.replay, color: Colors.white),
        SizedBox(width: 12),
        Text(
          "Play Again",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
