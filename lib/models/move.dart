import 'package:six_me_ludo_android/models/piece.dart';

import 'direction.dart';

class Move {
  late Piece? piece;
  late Direction? direction;
  late int? destinationIndex;
  late bool isKick;
  late bool isGoingHome;
  late bool isStartingKick;

  //  these will be used to help the ai look ahead
  //  I have no idea how I will actually factor these into the decision logic
  //  and it will likely generate a WHOLE lot of bugs
  //  But we'll cross that river when we get there.
  //  Don't forget to pass these to the constructor

  late int distanceToHomeBeforeMove;
  late int distanceToHomeAfterMove;
  late int distanceToClosestEnemyPieceBeforeMove;
  late int distanceToClosestEnemyPieceAfterMove;
  late int distanceToFarthestEnemyPieceBeforeMove;

  // --------------------------------------------------------------------------

  Move({
    required this.piece,
    required this.direction,
    required this.destinationIndex,
    required this.isKick,
    required this.isStartingKick,
    required this.isGoingHome,
  });

  static Move getNullMove() {
    return Move(
      piece: null,
      direction: null,
      destinationIndex: null,
      isGoingHome: false,
      isStartingKick: false,
      isKick: false,
    );
  }
}
