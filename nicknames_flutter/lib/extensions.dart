import 'dart:math';

extension ListExtension<T> on List<T> {
  T random() {
    final random = Random();
    return this[random.nextInt(length)];
  }
}