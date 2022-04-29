import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = const AssetImage("images/circle.png");
  AssetImage lucky = const AssetImage("images/rupee.png");
  AssetImage unlucky = const AssetImage("images/sadFace.png");
  List<String>? itemArray;
  int? luckyNumber;
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => 'empty');
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

  AssetImage getImage(int index) {
    String currentState = itemArray![index];

    switch (currentState) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unlucky;
      default:
        return circle;
    }
  }

  playGame(int index) {
    setState(() {
      if (luckyNumber == index) {
        itemArray![index] = 'lucky';
      } else {
        itemArray![index] = 'unlucky';
      }
    });
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray![luckyNumber!] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: itemArray!.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 50,
                    width: 50,
                    child: RaisedButton(
                      onPressed: () {
                        playGame(i);
                      },
                      child: Image(image: getImage(i)),
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              child: Text("Show all"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: () {
                resetGame();
              },
              child: Text("Reset"),
            ),
          ),
        ],
      ),
    );
  }
}
