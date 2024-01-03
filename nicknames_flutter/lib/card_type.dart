import 'package:flutter/material.dart';

enum CardType {
  red,
  blue,
  neutral,
  black,
  defaultType;

  Color getColor() {
    switch (this) {
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

  CardType next() {
    switch (this) {
      case CardType.red:
        return CardType.blue;
      case CardType.blue:
        return CardType.neutral;
      case CardType.neutral:
        return CardType.black;
      case CardType.black:
        return CardType.defaultType;
      case CardType.defaultType:
        return CardType.red;
    }
  }

  // Color getColor() {
  //   switch (this) {
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
}
