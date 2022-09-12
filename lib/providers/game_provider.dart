import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../models/game.dart';
import '../models/user.dart';

class GameProvider with ChangeNotifier {
  late Board board;

  // text controllers
  TextEditingController joinGameController = TextEditingController();

  // game
  late Game currentGame;
  late Stream<Game> currentGameStream;

  bool isJoinGameCodeValidLength() {
    return joinGameController.text.length == AppConstants.joinGameCodeLength;
  }

  void initialiseBoard(BuildContext context) {
    board = Board.generateBoard(context);
  }

  void initialiseGame(Game game) {
    currentGame = game;
    currentGameStream = DatabaseService.getCurrentGameStream(currentGame.id);
  }

  void syncGameData(Game game) {
    currentGame = game;
  }

  Future<void> hostGame(Users user, AppProvider appProvider) async {
    appProvider.setLoading(true, true);

    try {
      Game newGame = await DatabaseService.createGame(user);
      initialiseGame(newGame);
      appProvider.setLoading(false, true);
      NavigationService.goToGameScreen();
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }
}
