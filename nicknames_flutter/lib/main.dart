import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.setAlwaysOnTop(true);
  final String text = await rootBundle.loadString('assets/words_cz.txt');
  final words = text.split("\n");
  print(words.length);
  runApp(MainApp(words: words));
}

extension ListExtension<T> on List<T> {
  T random() {
    final random = Random();
    return this[random.nextInt(length)];
  }
}

class MainApp extends StatelessWidget {
  final List<String> words;

  const MainApp({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            for (var i = 0; i < 5; i++)
              Expanded(
                child: Row(
                  children: [
                    for (var j = 0; j < 5; j++)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Card(
                            text: words.random(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatefulWidget {
  final String text;

  const Card({
    super.key,
    required this.text,
  });

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  CardType type = CardType.defaultType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          switch (type) {
            case CardType.red:
              type = CardType.blue;
              break;
            case CardType.blue:
              type = CardType.neutral;
              break;
            case CardType.neutral:
              type = CardType.black;
              break;
            case CardType.black:
              type = CardType.defaultType;
              break;
            case CardType.defaultType:
              type = CardType.red;
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getColor(type),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.all(constraints.maxWidth < 250 ? 4.0 : 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffe1c8b2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xff9b8670),
                          width: 2,
                        ),
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned(
                              top: constraints.maxHeight / 2 - 40,
                              bottom: constraints.maxHeight / 2 - 2,
                              right: constraints.maxWidth / 2.5 - 30,
                              left: 10,
                              child: Transform.rotate(
                                angle: pi,
                                child: Center(
                                  child: AutoSizeText(
                                    widget.text.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xff716f58),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxFontSize: 20,
                                    minFontSize: 8,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight / 2 - 2,
                              bottom: constraints.maxHeight / 2 - 2,
                              right: constraints.maxWidth / 2.5 - 30,
                              left: 10,
                              child: Container(
                                color: const Color(0xffa4968a),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              bottom: constraints.maxHeight / 2,
                              right: 10,
                              left: constraints.maxWidth / 1.5 + 20 + 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffebd5c1),
                                    width: 4,
                                  ),
                                  color: const Color(0xffd8cab8),
                                ),
                                child: Opacity(opacity: 0.2, child: Image.asset("assets/head_silhouette.png", fit: BoxFit.contain)),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              left: 8,
                              height: constraints.maxHeight / 2 - 20,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    widget.text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      
                                      fontSize: 32,
                                    ),
                                    maxFontSize: 32,
                                    minFontSize: 8,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            if (type != CardType.defaultType)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                left: 8,
                                height: constraints.maxHeight / 2 - 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: getColor(type).withOpacity(0.25),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  );
                }
              ),
            ),
            Positioned(
              height: 200,
              width: 50,
              top: -50,
              right: 50,
              child: Transform.rotate(
                alignment: Alignment.topLeft,
                angle: pi / 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [
                        0.0,
                        0.8,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              height: 200,
              width: 15,
              top: -15,
              right: 40,
              child: Transform.rotate(
                alignment: Alignment.topLeft,
                angle: pi / 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.56],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Color getColor(CardType type) {
//   switch (type) {
//     case CardType.red:
//       return const Color(0xfff2a2a2);
//     case CardType.blue:
//       return const Color(0xffa2b4e2);
//     case CardType.neutral:
//       return const Color(0xffd8b858);
//     case CardType.black:
//       return const Color(0xff322626);
//     case CardType.defaultType:
//       return const Color(0xffe2cebc);
//   }
// }

Color getColor(CardType type) {
  switch (type) {
    case CardType.red:
      return Colors.red;
    case CardType.blue:
      return Colors.blue;
    case CardType.neutral:
      return Colors.yellow.shade700;
    case CardType.black:
      return Colors.black;
    case CardType.defaultType:
      return const Color(0xffe2cebc);
  }
}

enum CardType {
  red,
  blue,
  neutral,
  black,
  defaultType,
}
