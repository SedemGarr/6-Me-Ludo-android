import 'board.dart';

class Piece {
  late int owner;
  late int pieceNumber;
  late int position;
  late bool isHome;
  late bool isBased;

  Piece({
    required this.isBased,
    required this.isHome,
    required this.owner,
    required this.pieceNumber,
    required this.position,
  });

  static List<Piece> getDefaultPieces(int playerNumber) {
    List<Piece> pieces = [];

    for (int i = 0; i < 4; i++) {
      switch (playerNumber) {
        case 0:
          pieces.add(Piece(isBased: true, isHome: false, owner: playerNumber, pieceNumber: i, position: determineInitialPiecePosition(playerNumber, i)));
          break;
        case 1:
          pieces.add(Piece(isBased: true, isHome: false, owner: playerNumber, pieceNumber: i, position: determineInitialPiecePosition(playerNumber, i)));
          break;
        case 2:
          pieces.add(Piece(isBased: true, isHome: false, owner: playerNumber, pieceNumber: i, position: determineInitialPiecePosition(playerNumber, i)));
          break;
        case 3:
          pieces.add(Piece(isBased: true, isHome: false, owner: playerNumber, pieceNumber: i, position: determineInitialPiecePosition(playerNumber, i)));
          break;
        default:
      }
    }

    return pieces;
  }

  static int determineInitialPiecePosition(int playerNumber, int pieceNumber) {
    switch (playerNumber) {
      case 0:
        switch (pieceNumber) {
          case 0:
            return Board.playerOnePieceOneBaseIndex;
          case 1:
            return Board.playerOnePieceTwoBaseIndex;
          case 2:
            return Board.playerOnePieceThreeBaseIndex;
          case 3:
            return Board.playerOnePieceFourBaseIndex;
          default:
            return 0;
        }
      case 1:
        switch (pieceNumber) {
          case 0:
            return Board.playerTwoPieceOneBaseIndex;
          case 1:
            return Board.playerTwoPieceTwoBaseIndex;
          case 2:
            return Board.playerTwoPieceThreeBaseIndex;
          case 3:
            return Board.playerTwoPieceFourBaseIndex;
          default:
            return 0;
        }
      case 2:
        switch (pieceNumber) {
          case 0:
            return Board.playerThreePieceOneBaseIndex;
          case 1:
            return Board.playerThreePieceTwoBaseIndex;
          case 2:
            return Board.playerThreePieceThreeBaseIndex;
          case 3:
            return Board.playerThreePieceFourBaseIndex;
          default:
            return 0;
        }
      case 3:
        switch (pieceNumber) {
          case 0:
            return Board.playerFourPieceOneBaseIndex;
          case 1:
            return Board.playerFourPieceTwoBaseIndex;
          case 2:
            return Board.playerFourPieceThreeBaseIndex;
          case 3:
            return Board.playerFourPieceFourBaseIndex;
          default:
            return 0;
        }
      default:
        return 0;
    }
  }

  static final nullPiece = Piece(isBased: false, isHome: false, owner: -99, pieceNumber: -99, position: -99);

  Piece.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    isBased = json['isBased'];
    isHome = json['isHome'];
    pieceNumber = json['pieceNumber'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['isBased'] = isBased;
    data['isHome'] = isHome;
    data['pieceNumber'] = pieceNumber;
    data['position'] = position;
    return data;
  }

  @override
  bool operator ==(other) {
    return (other is Piece) && other.owner == owner && other.isBased == isBased && other.isHome == isHome && other.pieceNumber == pieceNumber && other.position == position;
  }

  @override
  int get hashCode => owner.hashCode ^ isBased.hashCode ^ isHome.hashCode ^ pieceNumber.hashCode ^ position.hashCode;
}
