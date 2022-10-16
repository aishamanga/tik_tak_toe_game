import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool OTurn = true; //first player os O
  List<String> DisplayXO = ["", "", "", "", "", "", "", "", ""];
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int OScore = 0;
  int XScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player O",
                          style: myTextStyle,
                        ),
                        Text(
                          OScore.toString(),
                          style: myTextStyle,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player X",
                          style: myTextStyle,
                        ),
                        Text(
                          XScore.toString(),
                          style: myTextStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 350,
            height: 350,
            child: GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          DisplayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (OTurn && DisplayXO[index] == '') {
        DisplayXO[index] = "O";
      } else if (!OTurn && DisplayXO[index] == '') {
        DisplayXO[index] = "X";
      }
      OTurn = !OTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //  0  1  2
    //  3  4  5
    //  6  7  8

    //1st row
    if (DisplayXO[0] == DisplayXO[1] &&
        DisplayXO[0] == DisplayXO[2] &&
        DisplayXO[0] != "") {
      _showWinDialog(DisplayXO[0]);
    }
    //2nd row
    if (DisplayXO[3] == DisplayXO[4] &&
        DisplayXO[3] == DisplayXO[5] &&
        DisplayXO[3] != "") {
      _showWinDialog(DisplayXO[3]);
    }
    //3rd row
    if (DisplayXO[6] == DisplayXO[7] &&
        DisplayXO[6] == DisplayXO[8] &&
        DisplayXO[6] != "") {
      _showWinDialog(DisplayXO[6]);
    }
    //1st column
    if (DisplayXO[0] == DisplayXO[3] &&
        DisplayXO[0] == DisplayXO[6] &&
        DisplayXO[0] != "") {
      _showWinDialog(DisplayXO[0]);
    }
    //2st column
    if (DisplayXO[1] == DisplayXO[4] &&
        DisplayXO[1] == DisplayXO[7] &&
        DisplayXO[1] != "") {
      _showWinDialog(DisplayXO[1]);
    }
    //3rd column
    if (DisplayXO[2] == DisplayXO[5] &&
        DisplayXO[2] == DisplayXO[8] &&
        DisplayXO[2] != "") {
      _showWinDialog(DisplayXO[2]);
    }
    //diagonal
    if (DisplayXO[0] == DisplayXO[4] &&
        DisplayXO[0] == DisplayXO[8] &&
        DisplayXO[0] != "") {
      _showWinDialog(DisplayXO[0]);
    }
    //diagonal
    if (DisplayXO[6] == DisplayXO[4] &&
        DisplayXO[6] == DisplayXO[2] &&
        DisplayXO[6] != "") {
      _showWinDialog(DisplayXO[6]);
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("WINNER IS: " + winner),
            actions: [
              TextButton(
                  onPressed: () {
                    //clear board function here
                  },
                  child: Text("Play Again"))
            ],
          );
        });

    if (winner == "O") {
      OScore += 1;
    } else if (winner == "X") {
      XScore += 1;
    }
  }

  void _clearBoard() {}
}
