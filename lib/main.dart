import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/cubit/game_controller_cubit.dart';
import 'package:tic_tac_toe/screens/screens.dart';

void main() {
  runApp(
    BlocProvider<GameControllerCubit>(
      create: (context) => GameControllerCubit(),
      child: MaterialApp(
        title: "Tic Tac Toe",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
              primary: Colors.white,
              backgroundColor: Colors.deepOrangeAccent,
              textStyle: const TextStyle(fontSize: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
          ),
        ),
        home: const Scaffold(
          backgroundColor: Colors.black,
          body: HomeScreen(),
        ),
      ),
    ),
  );
}
