import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

class Stats {
  late int counter;
  late int numberOfGames;
  late int numberOfGamesFinished;
  late int numberOfGamesWithOnlyAI;
  late int numberOfGamesWithOnlyHumans;
  late int numberOfGamesWithMixtureOfHumansAndAI;
  late int numberOfWins;
  late int numberOfKicks;
  late int numberOfTimesBeingKicked;
  late int numberOfTimesBeingViciousPlayer;
  late int numberOfTimesBeingPunchingBagPlayer;
  late List<int> favouriteColours;
  late String cummulativeTimeOfGames;

  Stats({
    required this.numberOfGames,
    required this.numberOfGamesFinished,
    required this.numberOfGamesWithMixtureOfHumansAndAI,
    required this.numberOfGamesWithOnlyAI,
    required this.numberOfGamesWithOnlyHumans,
    required this.numberOfKicks,
    required this.numberOfTimesBeingKicked,
    required this.numberOfTimesBeingPunchingBagPlayer,
    required this.numberOfTimesBeingViciousPlayer,
    required this.numberOfWins,
    required this.counter,
    required this.favouriteColours,
    required this.cummulativeTimeOfGames,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    numberOfGames = json['numberOfGames'];
    numberOfGamesFinished = json['numberOfGamesFinished'];
    numberOfGamesWithMixtureOfHumansAndAI = json['numberOfGamesWithMixtureOfHumansAndAI'];
    numberOfGamesWithOnlyAI = json['numberOfGamesWithOnlyAI'];
    numberOfGamesWithOnlyHumans = json['numberOfGamesWithOnlyHumans'];
    numberOfKicks = json['numberOfKicks'];
    numberOfTimesBeingKicked = json['numberOfTimesBeingKicked'];
    numberOfTimesBeingPunchingBagPlayer = json['numberOfTimesBeingPunchingBagPlayer'];
    numberOfTimesBeingViciousPlayer = json['numberOfTimesBeingViciousPlayer'];
    numberOfWins = json['numberOfWins'];
    counter = json['counter'];
    cummulativeTimeOfGames = json['cummulativeTimeOfGames'] ?? '0';
    if (json['favouriteColours'] != null) {
      favouriteColours = <int>[];
      json['favouriteColours'].forEach((v) {
        favouriteColours.add(v);
      });
    } else {
      favouriteColours = getDefaultFavouriteColors();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numberOfGames'] = numberOfGames;
    data['numberOfGamesFinished'] = numberOfGamesFinished;
    data['numberOfGamesWithMixtureOfHumansAndAI'] = numberOfGamesWithMixtureOfHumansAndAI;
    data['numberOfGamesWithOnlyAI'] = numberOfGamesWithOnlyAI;
    data['numberOfGamesWithOnlyHumans'] = numberOfGamesWithOnlyHumans;
    data['numberOfTimesBeingKicked'] = numberOfTimesBeingKicked;
    data['numberOfKicks'] = numberOfKicks;
    data['numberOfTimesBeingPunchingBagPlayer'] = numberOfTimesBeingPunchingBagPlayer;
    data['numberOfTimesBeingViciousPlayer'] = numberOfTimesBeingViciousPlayer;
    data['numberOfWins'] = numberOfWins;
    data['counter'] = counter;
    data['favouriteColours'] = favouriteColours.map((v) => v).toList();
    data['cummulativeTimeOfGames'] = cummulativeTimeOfGames;
    return data;
  }

  static List<int> getDefaultFavouriteColors() {
    return List.generate(4, (index) => 0, growable: false);
  }

  static Stats getDefaultStats() {
    return Stats(
      counter: 0,
      numberOfGames: 0,
      numberOfGamesFinished: 0,
      numberOfWins: 0,
      numberOfKicks: 0,
      numberOfTimesBeingKicked: 0,
      numberOfGamesWithMixtureOfHumansAndAI: 0,
      numberOfGamesWithOnlyAI: 0,
      numberOfGamesWithOnlyHumans: 0,
      numberOfTimesBeingPunchingBagPlayer: 0,
      numberOfTimesBeingViciousPlayer: 0,
      favouriteColours: getDefaultFavouriteColors(),
      cummulativeTimeOfGames: '0',
    );
  }

  void updateStats(Game game, Player player) {
    GameProvider gameProvider = Get.context!.read<GameProvider>();

    // always increment
    counter++;
    numberOfGames++;

    // winner
    if (game.finishedPlayers.isNotEmpty) {
      numberOfGamesFinished++;

      if (game.finishedPlayers.first == player.id) {
        numberOfWins++;
      }
    }

    // number of kicks
    numberOfKicks += player.numberOfTimesKickerInSession;
    numberOfTimesBeingKicked += player.numberOfTimesKickedInSession;

    // player type makeup
    bool doesGameHaveOnlyHumans = game.players.where((element) => !element.isAIPlayer).length == game.players.length;
    bool doesGameHaveOnlyAI = game.players.where((element) => element.isAIPlayer).length + 1 == game.players.length;
    if (doesGameHaveOnlyHumans) {
      numberOfGamesWithOnlyHumans++;
    } else if (doesGameHaveOnlyAI) {
      numberOfGamesWithOnlyAI++;
    } else {
      numberOfGamesWithMixtureOfHumansAndAI++;
    }

    // vicious or punching bag
    if (game.players.where((element) => element.numberOfTimesKickerInSession != 0).isNotEmpty) {
      Player viciousPlayer = gameProvider.getViciousPlayer(game);
      Player punchingBagPlayer = gameProvider.getPunchingBagPlayer(game);

      if (viciousPlayer.id == player.id) {
        numberOfTimesBeingViciousPlayer++;
      }

      if (punchingBagPlayer.id == player.id) {
        numberOfTimesBeingPunchingBagPlayer++;
      }
    }

    // time spent in games
    cummulativeTimeOfGames = GameProvider.getCummulativeDuration(cummulativeTimeOfGames, game.sessionStartedAt, game.sessionEndedAt);
  }
}
