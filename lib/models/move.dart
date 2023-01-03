import 'package:six_me_ludo_android/models/piece.dart';

import 'direction.dart';

class Move {
  late Piece? piece;
  late Direction? direction;
  late int? destinationIndex;
  late int? kickee;
  late bool isKick;
  late bool isGoingHome;
  late bool isStartingKick;

  //  these will be used to help the ai look ahead
  //  I have no idea how I will actually factor these into the decision logic
  //  and it will likely generate a WHOLE lot of bugs
  //  But we'll cross that river when we get there.
  //  Don't forget to pass these to the constructor
  late double weight;
  late int? distanceToHomeBeforeMove;
  late int? distanceToHomeAfterMove;
  late int? distanceToClosestEnemyPieceBeforeMove;
  late int? distanceToClosestEnemyPieceAfterMove;
  late int? distanceToFarthestEnemyPieceBeforeMove;
  late int? distanceToFarthestEnemyPieceAfterMove;

  // --------------------------------------------------------------------------

  Move({
    required this.piece,
    required this.direction,
    required this.destinationIndex,
    required this.isKick,
    required this.isStartingKick,
    required this.isGoingHome,
    required this.kickee,
    required this.weight,
    //  required this.distanceToHomeBeforeMove,
    //  required this.distanceToHomeAfterMove,
    //  required this.distanceToClosestEnemyPieceAfterMove,
    //  required this.distanceToClosestEnemyPieceBeforeMove,
    //  required this.distanceToFarthestEnemyPieceBeforeMove,
    //  required this.distanceToFarthestEnemyPieceAfterMove,
  });

  static Move getNullMove() {
    return Move(
      piece: null,
      direction: null,
      destinationIndex: null,
      kickee: null,
      // distanceToHomeAfterMove: null,
      // distanceToHomeBeforeMove: null,
      // distanceToClosestEnemyPieceAfterMove: null,
      // distanceToClosestEnemyPieceBeforeMove: null,
      // distanceToFarthestEnemyPieceAfterMove: null,
      // distanceToFarthestEnemyPieceBeforeMove: null,
      isGoingHome: false,
      isStartingKick: false,
      isKick: false,
      weight: 0.0,
    );
  }
}
