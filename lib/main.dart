import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raspisanie/src/features/auth/presentation/page/authscreen.dart';
import 'package:raspisanie/src/features/chat/presentation/page/chat.dart';
import 'package:raspisanie/src/features/raspisanie/presentation/page/raspisanie.dart';
import 'package:raspisanie/src/features/signup/presentation/page/registscreen.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(Run());
}

class Run extends StatelessWidget{

  final GoRouter router = GoRouter(
      routes: [GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(child: AuthScreen()),
        routes: [GoRoute(
            path: 'main',
            pageBuilder: (context, state) => MaterialPage(child: MainView()),
          routes: [GoRoute(
              path: 'chat',
            pageBuilder: (context, state) => MaterialPage(child: Chat())
          )]
        ),
        GoRoute(path: 'signup', pageBuilder: (context, state) => MaterialPage(child: Regist()))]
      )]
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: router,
    );
  }
}