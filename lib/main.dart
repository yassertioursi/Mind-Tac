import 'package:flutter/material.dart';
import 'package:mindtac/domain/models/game_model.dart';
import 'package:mindtac/presentation/pages/game_screen.dart';
import 'package:mindtac/utils/app_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
