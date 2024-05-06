import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raspisanie/features/authscreen/authscreen.dart';
import 'package:raspisanie/features/raspisanie/raspisanie.dart';
import 'package:raspisanie/features/registscreen/regist.dart';

void main() => runApp(Run());

class Run extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(244, 31, 31, 31),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700
          )
      ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400),
            bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          bodyMedium: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300)
        )
      ),
      title: 'Raspisanie',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/raspisanie': (context) => MainView(),
        '/signup': (context) => Regist()
      },
    );
  }
}