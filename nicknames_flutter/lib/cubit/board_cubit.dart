import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicknames_flutter/card_type.dart';
import 'package:nicknames_flutter/interaction_mode.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  static BoardInitial get defaultState => BoardInitial(Iterable.generate(25, (idx) => CardState(x: idx % 5, y: idx ~/ 5, type: CardType.defaultType)).toList(), boardInteraction: InteractionMode.changeColor);

  BoardCubit() : super(defaultState);

  List<String> words = [];
  List<String> ignored = [];
  List<String> recent = [];

  Future loadBoard() async {
    emit(defaultState);
    final String text = await rootBundle.loadString('assets/words_cz.txt');

    final ignoredFile = File('./ignored.txt');
    if (ignoredFile.existsSync()) {
      ignored = ignoredFile.readAsStringSync().split("\n");
    } else {
      ignoredFile.createSync();
    }

    words = text.split("\n");

    print(ignored.length);
    print(words.length);

    Set<String> wordsSet = {...words};
    wordsSet.removeAll(ignored);
    words = wordsSet.toList();

    words.shuffle();

    List<String> selectedWords = words.take(25).toList();

    emit(BoardLoaded(selectedWords, state.cards, boardInteraction: state.boardInteraction));
  }

  String getWord() {
    recent.add(words.skip(25 + recent.length).first);
    return recent.last;
  }

  void changeCardColor(int x, int y, CardType next) {
    final CardState card = state.at(x, y).copyWith(type: next);
    final List<CardState> cards = [...state.cards];
    cards.removeWhere((element) => element.x == x && element.y == y);
    cards.add(card);
    emit(BoardLoaded(words, cards, boardInteraction: state.boardInteraction));
  }
}
