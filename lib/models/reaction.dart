import '../services/game_status_service.dart';

class Reaction {
  late String reactionType;
  late String reactionURL;

  Reaction({required this.reactionType, required this.reactionURL});

  Reaction.fromJson(Map<String, dynamic> json) {
    reactionType = json['reactionType'];
    reactionURL = json['reactionURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reactionType'] = reactionType;
    data['reactionURL'] = reactionURL;
    return data;
  }

  static Reaction getBlankReaction() {
    return Reaction(reactionType: GameStatusService.blank, reactionURL: '');
  }

  static Reaction parseGameStatus(String status) {
    switch (status) {
      case GameStatusService.playerKick:
        return Reaction(reactionType: GameStatusService.playerKick, reactionURL: GameStatusService.getPlayerKickGif());
      case GameStatusService.playerJoined:
        return Reaction(reactionType: GameStatusService.playerJoined, reactionURL: GameStatusService.getPlayerJoinedGif());
      case GameStatusService.playerLeft:
        return Reaction(reactionType: GameStatusService.playerLeft, reactionURL: GameStatusService.getPlayerLeftGif());
      case GameStatusService.playerHome:
        return Reaction(reactionType: GameStatusService.playerHome, reactionURL: GameStatusService.getPlayerHomeGif());
      case GameStatusService.playerFinish:
        return Reaction(reactionType: GameStatusService.playerFinish, reactionURL: GameStatusService.getPlayerFinishGif());
      case GameStatusService.gameWaiting:
        return Reaction(reactionType: GameStatusService.gameWaiting, reactionURL: GameStatusService.getGameWaitingGif());
      case GameStatusService.gameStart:
        return Reaction(reactionType: GameStatusService.gameStart, reactionURL: GameStatusService.getGameStartGif());
      case GameStatusService.gameFinish:
        return Reaction(reactionType: GameStatusService.gameFinish, reactionURL: GameStatusService.getGameFinishGif());
      default:
        return Reaction.getBlankReaction();
    }
  }
}
