import 'package:flutter/material.dart';
import 'package:nicknames_flutter/card.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.words,
  });

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 5; i++)
          Expanded(
            child: Row(
              children: [
                for (var j = 0; j < 5; j++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: WordCard(
                        x: j,
                        y: i,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
