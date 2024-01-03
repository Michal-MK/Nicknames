import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicknames_flutter/card_type.dart';
import 'package:nicknames_flutter/cubit/board_cubit.dart';
import 'package:nicknames_flutter/interaction_mode.dart';

class WordCard extends StatelessWidget {
  final int x;
  final int y;

  const WordCard({
    super.key,
    required this.x,
    required this.y,
  });

  Widget build(BuildContext context) {
    final boardCubit = context.watch<BoardCubit>();
    CardState cardState = boardCubit.state.at(x, y);
    String text = boardCubit.state is BoardLoaded ? (boardCubit.state as BoardLoaded).words[x + y * 5] : "";

    return InkWell(
      onTap: () {
        InteractionMode interactionMode = boardCubit.state.boardInteraction;
        if (interactionMode == InteractionMode.changeColor) {
          boardCubit.changeCardColor(x, y, cardState.type.next());
        } else if (interactionMode == InteractionMode.changeWord) {
          // TODO
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardState.type.getColor(),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: LayoutBuilder(builder: (context, constraints) {
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
                                  text.toUpperCase(),
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
                                  text,
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
                          if (cardState.type != CardType.defaultType)
                            Positioned(
                              bottom: 8,
                              right: 8,
                              left: 8,
                              height: constraints.maxHeight / 2 - 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cardState.type.getColor().withOpacity(0.25),
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
              }),
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
