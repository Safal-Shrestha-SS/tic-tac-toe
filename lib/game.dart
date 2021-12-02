import 'package:flutter/material.dart';
import 'package:tic_tac/state.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  context.read<Square>().restart();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  context.read<Square>().restart();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context).size;
    List square = context.watch<Square>().square;

    return SafeArea(
      child: Material(
        child: Container(
            color: Colors.deepOrange,
            child: Center(
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<Square>().undo();
                            },
                            icon: Icon(Icons.undo_sharp),
                            tooltip: 'Undo',
                          ),
                          Text(
                            "Tic-Tac-Toe",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<Square>().restart();
                            },
                            icon: Icon(Icons.restart_alt),
                            tooltip: "Restart",
                          ),
                        ],
                      ),
                    ),
                    NextMove(),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: queryData.height / 2,
                      height: queryData.height / 2,
                      color: Colors.black,
                      padding: EdgeInsets.all(7),
                      child: GridView.builder(
                          itemCount: 9,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                var b = context.read<Square>().nextMove;
                                context.read<Square>().change(index, b);
                                if (context.read<Square>().checkWinner == 'O' ||
                                    context.read<Square>().checkWinner == 'X') {
                                  _showWinDialog(
                                      context.read<Square>().checkWinner);
                                } else if (context.read<Square>().checkWinner ==
                                    ' ') {
                                  _showDrawDialog();
                                }
                              },
                              child: Container(
                                height: queryData.height / 6,
                                color: Colors.teal[100],
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    square[index].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class NextMove extends StatelessWidget {
  const NextMove({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Next Player : ${context.watch<Square>().nextMove}");
  }
}
