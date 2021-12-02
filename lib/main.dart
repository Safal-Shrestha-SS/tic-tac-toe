import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/state.dart';

import 'game.dart';
import 'intial_loading_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>Square())],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialLoadingScreen(),
        '/game': (context)=>Game(),
      },
    );
  }
}
