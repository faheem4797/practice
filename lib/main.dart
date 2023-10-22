import 'package:flutter/material.dart';
import 'package:practice/ui/colors.dart';
import 'package:practice/ui/widgets/figure_image.dart';
import 'package:practice/ui/widgets/letters.dart';
import 'package:practice/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = "FLUTTER".toUpperCase();
  bool completed = false;
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text('Hangman'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, 'assets/hang.png'),
                figureImage(Game.tries >= 1, 'assets/head.png'),
                figureImage(Game.tries >= 2, 'assets/body.png'),
                figureImage(Game.tries >= 3, 'assets/ra.png'),
                figureImage(Game.tries >= 4, 'assets/la.png'),
                figureImage(Game.tries >= 5, 'assets/rl.png'),
                figureImage(Game.tries >= 6, 'assets/ll.png'),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),
          //    SizedBox(height: ,)
          Game.tries > 5
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'GAME OVER!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Game.tries = 0;
                            Game.selectedChar = [];
                            completed = false;
                          });
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restart_alt,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'RESTART',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Visibility(
                      visible: !completed,
                      child: SizedBox(
                        width: double.infinity,
                        height: 350,
                        child: GridView.count(
                          crossAxisCount: 6,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          padding: const EdgeInsets.all(8.0),
                          children: alphabets.map((e) {
                            return RawMaterialButton(
                              onPressed: Game.selectedChar.contains(e)
                                  ? null
                                  : completed
                                      ? null
                                      : () {
                                          setState(() {
                                            Game.selectedChar.add(e);
                                            debugPrint(
                                                Game.selectedChar.toString());
                                            if (!word
                                                .split('')
                                                .contains(e.toUpperCase())) {
                                              Game.tries++;
                                            }
                                            bool isCompleted = false;
                                            for (int i = 0;
                                                i <= word.length - 1;
                                                i++) {
                                              if (Game.selectedChar
                                                  .contains(word[i])) {
                                                isCompleted = true;
                                              } else {
                                                isCompleted = false;
                                              }
                                            }

                                            completed = isCompleted;
                                          });
                                        },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              fillColor: Game.selectedChar.contains(e)
                                  ? Colors.black87
                                  : Colors.blue,
                              child: Text(
                                e,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: completed,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'YOU WON!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: 180,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Game.tries = 0;
                                    Game.selectedChar = [];
                                    completed = false;
                                  });
                                },
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.restart_alt,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'RESTART',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
        ],
      ),
    );
  }
}
