import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:matrix2d/matrix2d.dart';

Matrix2d md = Matrix2d();

class Square extends ChangeNotifier {
  List _square = List.filled(9, ' ');
  List move = ['O', 'X'];
  List get square => _square;
  var nextMove = 'O';
  List history = List.generate(
      9, (i) => List.generate(9, (int index) => ' ', growable: false),
      growable: false);
  int count = -1;
  change(int a, var b) {
    if (_square[a] == ' ') {
      count++;
      _square[a] = b;
      nextMove = (b == 'X') ? 'O' : 'X';
      print(_square);
      List row = List.empty(growable: true);

      for (int i = 0; i < _square.length; i++) {
        row.add(_square[i]);
      }

      history[count] = row;

      // history = history.reshape(history.length ~/ 9, 9);
      _checkWinner();
      notifyListeners();
    }
  }

  undo() {
    if (count > -1) {
      // print(history);
      nextMove = (nextMove == 'X') ? 'O' : 'X';
      history[count] = List.generate(9, (index) => ' ');
      count--;
      if (count == -1) {
        _square = List.generate(9, (index) => ' ');
      } else {
        List row = List.empty(growable: true);
        for (int i = 0; i < _square.length; i++) {
          row.add(history[count][i]);
        }
        print(history[count]);
        _square = row;
      }

      notifyListeners();
    }
  }

  restart() {
    int randomIndex;
    randomIndex = Random().nextInt(move.length);
    nextMove = move[randomIndex];
    _square = List.filled(9, ' ');
    count = -1;
    history = List.generate(
        9, (i) => List.generate(9, (int index) => ' ', growable: false),
        growable: false);
    notifyListeners();
  }

  String _checkWinner() {
    List displayElement = _square;
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != ' ') {
      return (displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != ' ') {
      return (displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != ' ') {
      return (displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != ' ') {
      return (displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != ' ') {
      return (displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != ' ') {
      return (displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != ' ') {
      return (displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != ' ') {
      return (displayElement[2]);
    } else if (!displayElement.contains(' ')) {
      return (' ');
    } else
      return ('f');
  }

  String get checkWinner => _checkWinner();
}
