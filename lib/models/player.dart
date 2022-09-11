import 'dart:math';

import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/piece.dart';
import 'package:six_me_ludo_android/models/user.dart';

import '../utils/utils.dart';
import 'board.dart';
import 'game.dart';

class Player {
  late String id;
  late String psuedonym;
  late String avatar;
  late int reputationValue;
  late int playerColor;
  late int numberOfDieRolls;
  late bool hasLeft;
  late bool hasFinished;
  late bool isAIPlayer;
  late bool isPresent;
  late int numberOfTimesKickerInSession;
  late int numberOfTimesKickedInSession;
  late List<int> validIndices;
  late List<int> startBackKickIndices;
  late List<Piece> pieces;

  static String getPlayerReputation(int value) {
    if (value.isNegative) {
      return PlayerConstants.vicious;
    } else if (value == 0) {
      return PlayerConstants.averageJoe;
    } else {
      return PlayerConstants.pacifist;
    }
  }

  static List<int> playerOneValidIndices = [
    21,
    36,
    51,
    66,
    81,
    95,
    94,
    93,
    92,
    91,
    90,
    105,
    120,
    121,
    122,
    123,
    124,
    125,
    141,
    156,
    171,
    186,
    201,
    216,
    217,
    218,
    203,
    188,
    173,
    158,
    143,
    129,
    130,
    131,
    132,
    133,
    134,
    119,
    104,
    103,
    102,
    101,
    100,
    99,
    83,
    68,
    53,
    38,
    23,
    8,
    7,
    22,
    37,
    52,
    67,
    82,
    97
  ];
  static List<int> playerTwoValidIndices = [
    103,
    102,
    101,
    100,
    99,
    83,
    68,
    53,
    38,
    23,
    8,
    7,
    6,
    21,
    36,
    51,
    66,
    81,
    95,
    94,
    93,
    92,
    91,
    90,
    105,
    120,
    121,
    122,
    123,
    124,
    125,
    141,
    156,
    171,
    186,
    201,
    216,
    217,
    218,
    203,
    188,
    173,
    158,
    143,
    129,
    130,
    131,
    132,
    133,
    134,
    119,
    118,
    117,
    116,
    115,
    114,
    113
  ];
  static List<int> playerThreeValidIndices = [
    121,
    122,
    123,
    124,
    125,
    141,
    156,
    171,
    186,
    201,
    216,
    217,
    218,
    203,
    188,
    173,
    158,
    143,
    129,
    130,
    131,
    132,
    133,
    134,
    119,
    104,
    103,
    102,
    101,
    100,
    99,
    83,
    68,
    53,
    38,
    23,
    8,
    7,
    6,
    21,
    36,
    51,
    66,
    81,
    95,
    94,
    93,
    92,
    91,
    90,
    105,
    106,
    107,
    108,
    109,
    110,
    111
  ];
  static List<int> playerFourValidIndices = [
    203,
    188,
    173,
    158,
    143,
    129,
    130,
    131,
    132,
    133,
    134,
    119,
    104,
    103,
    102,
    101,
    100,
    99,
    83,
    68,
    53,
    38,
    23,
    8,
    7,
    6,
    21,
    36,
    51,
    66,
    81,
    95,
    94,
    93,
    92,
    91,
    90,
    105,
    120,
    121,
    122,
    123,
    124,
    125,
    141,
    156,
    171,
    186,
    201,
    216,
    217,
    202,
    187,
    172,
    157,
    142,
    127
  ];

  static final List<int> playerOneStartBackKickIndices = [6, 7, 8, 23, 38, 53];
  static final List<int> playerTwoStartBackKickIndices = [104, 119, 134, 133, 132, 131];
  static final List<int> playerThreeStartBackKickIndices = [120, 105, 90, 91, 92, 93];
  static final List<int> playerFourStartBackKickIndices = [218, 217, 216, 201, 186, 171];

  Player({
    required this.id,
    required this.avatar,
    required this.pieces,
    required this.hasLeft,
    required this.hasFinished,
    required this.isAIPlayer,
    required this.isPresent,
    required this.reputationValue,
    required this.numberOfTimesKickedInSession,
    required this.numberOfTimesKickerInSession,
    required this.playerColor,
    required this.numberOfDieRolls,
    required this.psuedonym,
    required this.startBackKickIndices,
    required this.validIndices,
  });

  void setReputationValue(int value) {
    if (isAIPlayer) {
      if (value != -2 || value != 2) {
        reputationValue = value;
      }
    } else {
      reputationValue = value;
    }
  }

  static IconData parsePlayerReputationToIcon(int value) {
    if (value.isNegative) {
      return PlayerConstants.viciousIcon;
    } else if (value == 0) {
      return PlayerConstants.averageJoeIcon;
    } else {
      return PlayerConstants.pacifistIcon;
    }
  }

  static List<int> getPlayerValidIndices(int playerNumber) {
    switch (playerNumber) {
      case 0:
        return playerOneValidIndices;
      case 1:
        return playerTwoValidIndices;
      case 2:
        return playerThreeValidIndices;
      case 3:
        return playerFourValidIndices;
      default:
        return [];
    }
  }

  static List<int> getPlayerStartBackKickIndices(int playerNumber) {
    switch (playerNumber) {
      case 0:
        return playerOneStartBackKickIndices;
      case 1:
        return playerTwoStartBackKickIndices;
      case 2:
        return playerThreeStartBackKickIndices;
      case 3:
        return playerFourStartBackKickIndices;
      default:
        return [];
    }
  }

  static int getPlayerStartIndex(int playerNumber) {
    switch (playerNumber) {
      case 0:
        return Board.playerOneStartIndex;
      case 1:
        return Board.playerTwoStartIndex;
      case 2:
        return Board.playerThreeStartIndex;
      case 3:
        return Board.playerFourStartIndex;
      default:
        return -1;
    }
  }

  static int getPlayerHomeIndex(int playerNumber) {
    switch (playerNumber) {
      case 0:
        return Board.playerOneHomeIndex;
      case 1:
        return Board.playerTwoHomeIndex;
      case 2:
        return Board.playerThreeHomeIndex;
      case 3:
        return Board.playerFourHomeIndex;
      default:
        return -1;
    }
  }

  static int getPlayerNumber(Game game) {
    return game.players.length;
  }

  static Player getDefaultPlayer(Users user, int playerNumber) {
    return Player(
      id: user.id,
      avatar: user.avatar,
      pieces: Piece.getDefaultPieces(playerNumber),
      playerColor: playerNumber,
      numberOfTimesKickedInSession: 0,
      numberOfTimesKickerInSession: 0,
      hasLeft: false,
      hasFinished: false,
      isAIPlayer: false,
      isPresent: true,
      psuedonym: user.psuedonym,
      numberOfDieRolls: 0,
      reputationValue: user.reputationValue,
      startBackKickIndices: playerOneStartBackKickIndices,
      validIndices: playerOneValidIndices,
    );
  }

  static Player getJoiningPlayer(Users user, Game game) {
    return Player(
      id: user.id,
      avatar: user.avatar,
      pieces: Piece.getDefaultPieces(Player.getPlayerNumber(game)),
      playerColor: Player.getPlayerNumber(game),
      hasLeft: false,
      hasFinished: false,
      numberOfTimesKickedInSession: 0,
      numberOfTimesKickerInSession: 0,
      isAIPlayer: false,
      isPresent: true,
      psuedonym: user.psuedonym,
      numberOfDieRolls: 0,
      reputationValue: user.reputationValue,
      validIndices: Player.getPlayerValidIndices(Player.getPlayerNumber(game)),
      startBackKickIndices: Player.getPlayerStartBackKickIndices(Player.getPlayerNumber(game)),
    );
  }

  static Player getJoiningAIPlayer(String id, Game game, Users user) {
    return Player(
      id: id,
      avatar: Utils.generateRandomUserAvatar(),
      pieces: Piece.getDefaultPieces(Player.getPlayerNumber(game)),
      playerColor: Player.getPlayerNumber(game),
      hasLeft: false,
      hasFinished: false,
      numberOfTimesKickedInSession: 0,
      numberOfTimesKickerInSession: 0,
      isAIPlayer: true,
      isPresent: true,
      psuedonym: Utils.getRandomPseudonym(),
      numberOfDieRolls: 0,
      reputationValue: getAIPersonality(game, user),
      startBackKickIndices: Player.getPlayerStartBackKickIndices(Player.getPlayerNumber(game)),
      validIndices: Player.getPlayerValidIndices(Player.getPlayerNumber(game)),
    );
  }

  static int getAIPersonality(Game game, Users user) {
    switch (user.settings.aiPersonalityPreference) {
      case PlayerConstants.averageJoe:
        return PlayerConstants.averageJoeValue;
      case PlayerConstants.vicious:
        return PlayerConstants.viciousValue;
      case PlayerConstants.pacifist:
        return PlayerConstants.pacifistValue;
      case PlayerConstants.randomPersonality:
        return Random().nextInt(PlayerConstants.listOfRepuations.length);
      default:
        return 0;
    }
  }

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    reputationValue = json['reputationValue'];
    psuedonym = json['psuedonym'];
    playerColor = json['playerColor'];
    numberOfDieRolls = json['numberOfDieRolls'];
    numberOfTimesKickedInSession = json['numberOfTimesKickedInSession'];
    numberOfTimesKickerInSession = json['numberOfTimesKickerInSession'];
    hasLeft = json['hasLeft'];
    hasFinished = json['hasFinished'];
    isAIPlayer = json['isAIPlayer'];
    isPresent = json['isPresent'];
    if (json['validIndices'] != null) {
      validIndices = <int>[];
      json['validIndices'].forEach((v) {
        validIndices.add(v);
      });
    }
    if (json['startBackKickIndices'] != null) {
      startBackKickIndices = <int>[];
      json['startBackKickIndices'].forEach((v) {
        startBackKickIndices.add(v);
      });
    }
    if (json['pieces'] != null) {
      pieces = <Piece>[];
      json['pieces'].forEach((v) {
        pieces.add(Piece.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['reputationValue'] = reputationValue;
    data['psuedonym'] = psuedonym;
    data['playerColor'] = playerColor;
    data['numberOfDieRolls'] = numberOfDieRolls;
    data['hasLeft'] = hasLeft;
    data['hasFinished'] = hasFinished;
    data['numberOfTimesKickedInSession'] = numberOfTimesKickedInSession;
    data['numberOfTimesKickerInSession'] = numberOfTimesKickerInSession;
    data['isAIPlayer'] = isAIPlayer;
    data['isPresent'] = isPresent;
    data['validIndices'] = validIndices.map((v) => v).toList();
    data['startBackKickIndices'] = startBackKickIndices.map((v) => v).toList();
    data['pieces'] = pieces.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  bool operator ==(other) {
    return (other is Player && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
