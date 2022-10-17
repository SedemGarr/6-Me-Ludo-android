enum Direction {
  forward,
  backward,
}

extension ParseToString on Direction {
  String parseToString() {
    return toString().split('.').last;
  }
}
