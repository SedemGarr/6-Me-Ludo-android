import 'package:six_me_ludo_android/models/piece.dart';

class Move {
  late Piece? piece;
  late String direction;
  late int destinationIndex;
  late bool isKick;
  late bool isGoingHome;
  late bool isStartingKick;

  Move({required this.piece, required this.direction, required this.destinationIndex, required this.isKick, required this.isStartingKick, required this.isGoingHome});

  static Move getNullMove() {
    return Move(piece: null, direction: '', destinationIndex: 999, isGoingHome: false, isStartingKick: false, isKick: false);
  }
}
