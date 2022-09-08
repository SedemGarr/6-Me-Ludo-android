import 'package:flutter/cupertino.dart';
import 'package:six_me_ludo_android/models/board.dart';

class GameProvider with ChangeNotifier {
  late Board board;

  void initialiseBoard(BuildContext context) {
    board = Board.generateBoard(context);
  }
}
