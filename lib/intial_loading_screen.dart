import 'package:flutter/material.dart';

class InitialLoadingScreen extends StatefulWidget {
  static const String id = 'initial_loading_screen';
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  _InitialLoadingScreenState createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 200),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Center(
              child: Text('Hello'),
            );
          },
          onEnd: () {
            Navigator.pushNamed(context, '/game');
          },
        ),
      ),
    );
  }
}
