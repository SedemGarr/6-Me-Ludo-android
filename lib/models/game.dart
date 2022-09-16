import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/models/message.dart';
import 'package:six_me_ludo_android/models/piece.dart';
import 'package:six_me_ludo_android/models/reaction.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/models/user_settings.dart';
import '../constants/player_constants.dart';
import '../services/game_status_service.dart';
import 'die.dart';
import 'player.dart';

class Game {
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
  late int maxPlayers;
  late int playerTurn;
  late Die die;
  late Piece? selectedPiece;
  late UserSettings hostSettings;
  late List<Player> players;
  late List<Message> thread;
  late List<String> finishedPlayers;
  late List<String> bannedPlayers;
  late List<String> kickedPlayers;
  late List<String> playerIds;

  Game({
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
    required this.thread,
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

  static Game autoFillWithAIPlayers(Game game, Users user) {
    for (int i = 0; i < (4 - game.maxPlayers); i++) {
      game.players.add(Player.getJoiningAIPlayer(i.toString(), game, user));
      game.playerIds.add(i.toString());
    }

    return game;
  }

  static Game getDefaultGame(Users user, String gameId) {
    return Game(
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
      thread: [],
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
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdatedAt = json['lastUpdatedAt'] == null
        ? DateTime.parse(DateTime.now().toString()).toString()
        : json['lastUpdatedAt'] is String
            ? json['lastUpdatedAt']
            : DateTime.parse(json['lastUpdatedAt'].toDate().toString()).toString();
    maxPlayers = json['maxPlayers'];
    playerTurn = json['playerTurn'];
    die = Die.fromJson(json['die']);

    selectedPiece = json['selectedPiece'] == null ? null : Piece.fromJson(json['selectedPiece']);
    if (json['bannedPlayers'] != null) {
      bannedPlayers = <String>[];
      json['bannedPlayers'].forEach((v) {
        bannedPlayers.add(v);
      });
    }
    if (json['kickedPlayers'] != null) {
      kickedPlayers = <String>[];
      json['kickedPlayers'].forEach((v) {
        kickedPlayers.add(v);
      });
    }
    if (json['playerIds'] != null) {
      playerIds = <String>[];
      json['playerIds'].forEach((v) {
        playerIds.add(v);
      });
    }
    if (json['players'] != null) {
      players = <Player>[];
      json['players'].forEach((v) {
        players.add(Player.fromJson(v));
      });
    }
    if (json['finishedPlayers'] != null) {
      finishedPlayers = <String>[];
      json['finishedPlayers'].forEach((v) {
        finishedPlayers.add(v);
      });
    }
    if (json['thread'] != null) {
      thread = <Message>[];
      json['thread'].forEach((v) {
        thread.add(Message.fromJson(v));
      });
      thread = [...thread.reversed.toList()];
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
    data['maxPlayers'] = maxPlayers;
    data['playerTurn'] = playerTurn;
    data['selectedPiece'] = selectedPiece == null ? null : selectedPiece!.toJson();
    data['die'] = die.toJson();
    data['thread'] = thread.map((v) => v.toJson()).toList().reversed.toList();
    data['bannedPlayers'] = bannedPlayers.map((v) => v).toList();
    data['kickedPlayers'] = kickedPlayers.map((v) => v).toList();
    data['playerIds'] = playerIds.map((v) => v).toList();
    data['players'] = players.map((v) => v.toJson()).toList();
    data['finishedPlayers'] = finishedPlayers.map((v) => v).toList();
    return data;
  }
}
