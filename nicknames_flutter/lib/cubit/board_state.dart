part of 'board_cubit.dart';

@immutable
sealed class BoardState {
  final InteractionMode boardInteraction;
  final List<CardState> cards;

  const BoardState(this.cards, {required this.boardInteraction});

  CardState at(int x, int y) {
    if (cards.isEmpty) {
      return const CardState(x: 0, y: 0, type: CardType.defaultType);
    }
    return cards.firstWhere((element) => element.x == x && element.y == y);
  }
}

final class BoardInitial extends BoardState {
  const BoardInitial(super.cards, {required super.boardInteraction});
}

final class BoardLoaded extends BoardState {
  final List<String> words;

  const BoardLoaded(this.words, super.cards, {required super.boardInteraction});
}

class CardState {
  final int x;
  final int y;
  final CardType type;

  const CardState({
    required this.x,
    required this.y,
    required this.type,
  });

  CardState copyWith({
    int? x,
    int? y,
    CardType? type,
  }) {
    return CardState(
      x: x ?? this.x,
      y: y ?? this.y,
      type: type ?? this.type,
    );
  }
}
