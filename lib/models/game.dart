import 'dart:math';

import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/models/piece.dart';
import 'package:six_me_ludo_android/models/reaction.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/models/user_settings.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:uuid/uuid.dart';
import '../constants/player_constants.dart';
import '../services/game_status_service.dart';
import 'die.dart';
import 'player.dart';

class Game {
  late String createdAt;
  late String lastUpdatedBy;
  late String lastUpdatedAt;
  late String id;
  late String hostId;
  late Reaction reaction;
  late bool canPass;
  late bool canPlay;
  late bool hasStarted;
  late bool hasFinished;
  late bool hasSessionEnded;
  late bool hasRestarted;
  late bool shouldAssistStart;
  late bool shouldAutoStart;
  late bool hasAdaptiveAI;
  late bool isOffline;
  late int maxPlayers;
  late int playerTurn;
  late Die die;
  late Piece? selectedPiece;
  late UserSettings hostSettings;
  late List<Player> players;
  late List<String> finishedPlayers;
  late List<String> bannedPlayers;
  late List<String> kickedPlayers;
  late List<String> playerIds;

  Game({
    required this.createdAt,
    required this.lastUpdatedBy,
    required this.lastUpdatedAt,
    required this.id,
    required this.die,
    required this.playerTurn,
    required this.canPass,
    required this.canPlay,
    required this.hasFinished,
    required this.hasStarted,
    required this.hasSessionEnded,
    required this.shouldAssistStart,
    required this.shouldAutoStart,
    required this.hostId,
    required this.hostSettings,
    required this.isOffline,
    required this.hasAdaptiveAI,
    required this.reaction,
    required this.players,
    required this.selectedPiece,
    required this.maxPlayers,
    required this.bannedPlayers,
    required this.kickedPlayers,
    required this.playerIds,
    required this.hasRestarted,
    required this.finishedPlayers,
  });

  static Color determinePlayerColor(int colorIndex) {
    if (colorIndex < PlayerConstants.swatchList.length) {
      return PlayerConstants.swatchList[colorIndex].playerColor;
    } else {
      return PlayerConstants.swatchList[PlayerConstants.swatchList.length - 1].playerColor;
    }
  }

  static Color determinePlayerSelectedColor(int colorIndex) {
    if (colorIndex < PlayerConstants.swatchList.length) {
      return PlayerConstants.swatchList[colorIndex].playerSelectedColor;
    } else {
      return PlayerConstants.swatchList[PlayerConstants.swatchList.length - 1].playerColor;
    }
  }

  static Game autoFillWithAIPlayers(Game game, Users user, Uuid uuid) {
    Random random = Random();

    for (int i = 0; i < (4 - game.maxPlayers); i++) {
      String id = Utils.getAIPlayerId(uuid);

      game.players.add(Player.getJoiningAIPlayer(id, game, user, random));
      game.playerIds.add(id);
    }

    return game;
  }

  static Game getDefaultGame(Users user, String gameId, bool isOffline) {
    return Game(
      createdAt: DateTime.now().toString(),
      hostSettings: user.settings,
      reaction: Reaction.parseGameStatus(GameStatusService.gameWaiting),
      id: gameId,
      die: Die.getDefaultDie(),
      bannedPlayers: [],
      kickedPlayers: [],
      finishedPlayers: [],
      lastUpdatedBy: user.id,
      lastUpdatedAt: '',
      canPass: false,
      canPlay: false,
      hasFinished: false,
      hasRestarted: false,
      hasSessionEnded: false,
      isOffline: isOffline,
      hasAdaptiveAI: user.settings.prefersAdaptiveAI,
      shouldAssistStart: user.settings.prefersStartAssist,
      shouldAutoStart: user.settings.prefersAutoStart,
      maxPlayers: user.settings.maxPlayers,
      playerTurn: 0,
      selectedPiece: null,
      hasStarted: false,
      hostId: user.id,
      players: [Player.getDefaultPlayer(user, 0)],
      playerIds: [user.id],
    );
  }

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostSettings = UserSettings.fromJson(json['hostSettings']);
    reaction = Reaction.fromJson(json['reaction']);
    hostId = json['hostId'];
    hasFinished = json['hasFinished'];
    canPass = json['canPass'];
    canPlay = json['canPlay'];
    hasStarted = json['hasStarted'];
    hasRestarted = json['hasRestarted'];
    hasSessionEnded = json['hasSessionEnded'];
    shouldAssistStart = json['shouldAssistStart'];
    shouldAutoStart = json['shouldAutoStart'];
    hasAdaptiveAI = json['hasAdaptiveAI'];
    isOffline = json['isOffline'];
    lastUpdatedBy = json['lastUpdatedBy'];
    createdAt = json['createdAt'] == null
        ? DateTime.now().toString()
        : json['createdAt'] is int
            ? DateTime.fromMillisecondsSinceEpoch(json['createdAt']).toString()
            : json['createdAt'] is String
                ? json['createdAt']
                : DateTime.now().toString();
    lastUpdatedAt = json['lastUpdatedAt'] == null
        ? DateTime.now().toString()
        : json['lastUpdatedAt'] is int
            ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdatedAt']).toString()
            : json['lastUpdatedAt'] is String
                ? json['lastUpdatedAt']
                : DateTime.now().toString();
    maxPlayers = json['maxPlayers'];
    playerTurn = json['playerTurn'];
    die = Die.fromJson(json['die']);
    selectedPiece = json['selectedPiece'] == null ? null : Piece.fromJson(json['selectedPiece']);
    if (json['bannedPlayers'] != null) {
      bannedPlayers = <String>[];
      json['bannedPlayers'].forEach((v) {
        bannedPlayers.add(v);
      });
    } else {
      bannedPlayers = <String>[];
    }

    if (json['kickedPlayers'] != null) {
      kickedPlayers = <String>[];
      json['kickedPlayers'].forEach((v) {
        kickedPlayers.add(v);
      });
    } else {
      kickedPlayers = <String>[];
    }
    if (json['playerIds'] != null) {
      playerIds = <String>[];
      json['playerIds'].forEach((v) {
        playerIds.add(v);
      });
    } else {
      playerIds = <String>[];
    }
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players.add(Player.fromJson(v));
      });
    } else {
      players = <Player>[];
    }
    if (json['finishedPlayers'] != null) {
      finishedPlayers = <String>[];
      json['finishedPlayers'].forEach((v) {
        finishedPlayers.add(v);
      });
    } else {
      finishedPlayers = <String>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hostSettings'] = hostSettings.toJson();
    data['reaction'] = reaction.toJson();
    data['hostId'] = hostId;
    data['canPass'] = canPass;
    data['canPlay'] = canPlay;
    data['hasStarted'] = hasStarted;
    data['hasFinished'] = hasFinished;
    data['hasSessionEnded'] = hasSessionEnded;
    data['hasRestarted'] = hasRestarted;
    data['shouldAssistStart'] = shouldAssistStart;
    data['shouldAutoStart'] = shouldAutoStart;
    data['hasAdaptiveAI'] = hasAdaptiveAI;
    data['lastUpdatedBy'] = lastUpdatedBy;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['createdAt'] = createdAt;
    data['isOffline'] = isOffline;
    data['maxPlayers'] = maxPlayers;
    data['playerTurn'] = playerTurn;
    data['selectedPiece'] = selectedPiece == null ? null : selectedPiece!.toJson();
    data['die'] = die.toJson();
    data['bannedPlayers'] = bannedPlayers.map((v) => v).toList();
    data['kickedPlayers'] = kickedPlayers.map((v) => v).toList();
    data['playerIds'] = playerIds.map((v) => v).toList();
    data['players'] = players.map((v) => v.toJson()).toList();
    data['finishedPlayers'] = finishedPlayers.map((v) => v).toList();
    return data;
  }

  @override
  bool operator ==(other) {
    return (other is Game && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
