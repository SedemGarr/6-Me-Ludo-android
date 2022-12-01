import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';

import '../providers/theme_provider.dart';
import 'cell.dart';

class Board {
  static const int boardGridColumnCount = 15;
  static const int boardGridCellCount = boardGridColumnCount * boardGridColumnCount;

  static final List<int> playerOneBaseIndices = [
    0,
    1,
    2,
    3,
    4,
    5,
    15,
    16,
    17,
    18,
    19,
    20,
    30,
    31,
    32,
    33,
    34,
    35,
    45,
    46,
    47,
    48,
    49,
    50,
    60,
    61,
    62,
    63,
    64,
    65,
    75,
    76,
    77,
    78,
    79,
    80
  ];
  static final List<int> playerTwoBaseIndices = [
    9,
    10,
    11,
    12,
    13,
    14,
    24,
    25,
    26,
    27,
    28,
    29,
    39,
    40,
    41,
    42,
    43,
    44,
    54,
    55,
    56,
    57,
    58,
    59,
    69,
    70,
    71,
    72,
    73,
    74,
    84,
    85,
    86,
    87,
    88,
    89
  ];
  static final List<int> playerThreeBaseIndices = [
    135,
    136,
    137,
    138,
    139,
    140,
    150,
    151,
    152,
    153,
    154,
    155,
    165,
    166,
    167,
    168,
    169,
    170,
    180,
    181,
    182,
    183,
    184,
    185,
    195,
    196,
    197,
    198,
    199,
    200,
    210,
    211,
    212,
    213,
    214,
    215
  ];
  static final List<int> playerFourBaseIndices = [
    144,
    145,
    146,
    147,
    148,
    149,
    159,
    160,
    161,
    162,
    163,
    164,
    174,
    175,
    176,
    177,
    178,
    179,
    189,
    190,
    191,
    192,
    193,
    194,
    204,
    205,
    206,
    207,
    208,
    209,
    219,
    220,
    221,
    222,
    223,
    224,
  ];
  static final List<int> playerOneHomeStretchIndices = [21, 22, 37, 52, 67, 82];
  static final List<int> playerTwoHomeStretchIndices = [103, 118, 117, 116, 115, 114];
  static final List<int> playerThreeHomeStretchIndices = [121, 106, 107, 108, 109, 110];
  static final List<int> playerFourHomeStretchIndices = [203, 202, 187, 172, 157, 142];
  static const int playerOneStartIndex = 21;
  static const int playerTwoStartIndex = 103;
  static const int playerThreeStartIndex = 121;
  static const int playerFourStartIndex = 203;
  static const int playerOneHomeIndex = 97;
  static const int playerTwoHomeIndex = 113;
  static const int playerThreeHomeIndex = 111;
  static const int playerFourHomeIndex = 127;
  static final List<int> homeIndices = [126, 96, 112, 128, 98];
  static const int playerOnePieceOneBaseIndex = 19;
  static const int playerOnePieceTwoBaseIndex = 16;
  static const int playerOnePieceThreeBaseIndex = 61;
  static const int playerOnePieceFourBaseIndex = 64;
  static const int playerTwoPieceOneBaseIndex = 73;
  static const int playerTwoPieceTwoBaseIndex = 28;
  static const int playerTwoPieceThreeBaseIndex = 25;
  static const int playerTwoPieceFourBaseIndex = 70;
  static const int playerThreePieceOneBaseIndex = 151;
  static const int playerThreePieceTwoBaseIndex = 196;
  static const int playerThreePieceThreeBaseIndex = 199;
  static const int playerThreePieceFourBaseIndex = 154;
  static const int playerFourPieceOneBaseIndex = 205;
  static const int playerFourPieceTwoBaseIndex = 208;
  static const int playerFourPieceThreeBaseIndex = 163;
  static const int playerFourPieceFourBaseIndex = 160;

  late List<Cell> cells = [];

  Board({required this.cells});

  // cell color
  static Color determineCellColor(int index, BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    if (playerOnePieceOneBaseIndex == index) {
      return backgroundColor;
    } else if (playerOnePieceTwoBaseIndex == index) {
      return backgroundColor;
    } else if (playerOnePieceThreeBaseIndex == index) {
      return backgroundColor;
    } else if (playerOnePieceFourBaseIndex == index) {
      return backgroundColor;
    } else if (playerTwoPieceOneBaseIndex == index) {
      return backgroundColor;
    } else if (playerTwoPieceTwoBaseIndex == index) {
      return backgroundColor;
    } else if (playerTwoPieceThreeBaseIndex == index) {
      return backgroundColor;
    } else if (playerTwoPieceFourBaseIndex == index) {
      return backgroundColor;
    } else if (playerThreePieceOneBaseIndex == index) {
      return backgroundColor;
    } else if (playerThreePieceTwoBaseIndex == index) {
      return backgroundColor;
    } else if (playerThreePieceThreeBaseIndex == index) {
      return backgroundColor;
    } else if (playerThreePieceFourBaseIndex == index) {
      return backgroundColor;
    } else if (playerFourPieceOneBaseIndex == index) {
      return backgroundColor;
    } else if (playerFourPieceTwoBaseIndex == index) {
      return backgroundColor;
    } else if (playerFourPieceThreeBaseIndex == index) {
      return backgroundColor;
    } else if (playerFourPieceFourBaseIndex == index) {
      return backgroundColor;
    } else if (homeIndices.contains(index)) {
      return backgroundColor;
    } else if (playerOneBaseIndices.contains(index)) {
      return PlayerConstants.swatchList[0].playerColor;
    } else if (playerTwoBaseIndices.contains(index)) {
      return PlayerConstants.swatchList[1].playerColor;
    } else if (playerThreeBaseIndices.contains(index)) {
      return PlayerConstants.swatchList[2].playerColor;
    } else if (playerFourBaseIndices.contains(index)) {
      return PlayerConstants.swatchList[3].playerColor;
    } else if (playerOneHomeStretchIndices.contains(index)) {
      return PlayerConstants.swatchList[0].playerColor;
    } else if (playerTwoHomeStretchIndices.contains(index)) {
      return PlayerConstants.swatchList[1].playerColor;
    } else if (playerThreeHomeStretchIndices.contains(index)) {
      return PlayerConstants.swatchList[2].playerColor;
    } else if (playerFourHomeStretchIndices.contains(index)) {
      return PlayerConstants.swatchList[3].playerColor;
    } else if (playerOneStartIndex == index) {
      return PlayerConstants.swatchList[0].playerColor;
    } else if (playerTwoStartIndex == index) {
      return PlayerConstants.swatchList[1].playerColor;
    } else if (playerThreeStartIndex == index) {
      return PlayerConstants.swatchList[2].playerColor;
    } else if (playerFourStartIndex == index) {
      return PlayerConstants.swatchList[3].playerColor;
    } else {
      return backgroundColor;
    }
  }

  // cell icon
  static IconData? determineCellIcon(int index) {
    if (index == 21) {
      return Icons.keyboard_arrow_left;
    } else if (index == 7) {
      return Icons.keyboard_arrow_left;
    } else if (index == 121) {
      return Icons.keyboard_arrow_down;
    } else if (index == 105) {
      return Icons.keyboard_arrow_down;
    } else if (index == 203) {
      return Icons.keyboard_arrow_right;
    } else if (index == 217) {
      return Icons.keyboard_arrow_right;
    } else if (index == 103) {
      return Icons.keyboard_arrow_up;
    } else if (index == 119) {
      return Icons.keyboard_arrow_up;
    } else if (index == 97 || index == 111 || index == 113 || index == 127) {
      return Icons.home_filled;
    } else {
      return AppIcons.homeIcon;
    }
  }

  // cell icon color
  static Color? determineCellIconColor(int index) {
    if (index == 21) {
      return ThemeProvider.getContrastingColor(PlayerConstants.swatchList[0].playerColor);
    } else if (index == 7) {
      return PlayerConstants.swatchList[0].playerColor;
    } else if (index == 121) {
      return ThemeProvider.getContrastingColor(PlayerConstants.swatchList[2].playerColor);
    } else if (index == 105) {
      return PlayerConstants.swatchList[2].playerColor;
    } else if (index == 203) {
      return ThemeProvider.getContrastingColor(PlayerConstants.swatchList[1].playerColor);
    } else if (index == 217) {
      return PlayerConstants.swatchList[3].playerColor;
    } else if (index == 103) {
      return ThemeProvider.getContrastingColor(PlayerConstants.swatchList[3].playerColor);
    } else if (index == 119) {
      return PlayerConstants.swatchList[1].playerColor;
    } else if (index == 97) {
      return PlayerConstants.swatchList[0].playerColor;
    } else if (index == 113) {
      return PlayerConstants.swatchList[1].playerColor;
    } else if (index == 111) {
      return PlayerConstants.swatchList[2].playerColor;
    } else if (index == 127) {
      return PlayerConstants.swatchList[3].playerColor;
    } else {
      return Colors.transparent;
    }
  }

  static Border? determineCellBorder(int index) {
    if (index == 112 ||
        index == 41 ||
        index == 42 ||
        index == 56 ||
        index == 57 ||
        index == 191 ||
        index == 192 ||
        index == 176 ||
        index == 177 ||
        index == 32 ||
        index == 33 ||
        index == 47 ||
        index == 48 ||
        index == 167 ||
        index == 168 ||
        index == 182 ||
        index == 183 ||
        index == 71 ||
        index == 72 ||
        index == 55 ||
        index == 40 ||
        index == 26 ||
        index == 27 ||
        index == 58 ||
        index == 43 ||
        index == 62 ||
        index == 63 ||
        index == 17 ||
        index == 18 ||
        index == 31 ||
        index == 46 ||
        index == 49 ||
        index == 34 ||
        index == 197 ||
        index == 198 ||
        index == 152 ||
        index == 153 ||
        index == 181 ||
        index == 166 ||
        index == 184 ||
        index == 169 ||
        index == 206 ||
        index == 207 ||
        index == 161 ||
        index == 162 ||
        index == 190 ||
        index == 175 ||
        index == 193 ||
        index == 178) {
      return null;
    } else if (index == 5) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 2),
        bottom: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 9) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 2),
        top: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 135) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 1),
        top: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 215) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 219) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 2),
        top: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 75) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 1),
        top: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 1 || index == 2 || index == 3 || index == 4 || index == 10 || index == 11 || index == 12 || index == 13) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 211 || index == 212 || index == 213 || index == 214 || index == 220 || index == 221 || index == 222 || index == 223) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 224) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 2),
        left: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 210) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 2),
        top: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 0) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 2),
        right: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 14) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 2),
        right: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 209 || index == 194 || index == 179 || index == 164 || index == 74 || index == 59 || index == 44 || index == 29 || index == 14) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 195 || index == 180 || index == 165 || index == 150 || index == 60 || index == 45 || index == 30 || index == 15) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 149) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 2),
        right: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 204 || index == 111 || index == 189 || index == 174 || index == 159 || index == 69 || index == 54 || index == 39 || index == 24) {
      return const Border(top: BorderSide(color: CSSColors.black, width: 1));
    } else if (index == 134 || index == 119 || index == 104) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 1),
        right: BorderSide(color: CSSColors.black, width: 1),
        bottom: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 89) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 1),
        bottom: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 200 || index == 185 || index == 113 || index == 170 || index == 155 || index == 65 || index == 50 || index == 35 || index == 20) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 136 || index == 137 || index == 138 || index == 97 || index == 139 || index == 145 || index == 146 || index == 147 || index == 148) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 75 || index == 76 || index == 127 || index == 77 || index == 78 || index == 79 || index == 85 || index == 86 || index == 87 || index == 88 || index == 89) {
      return const Border(
        left: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 144 || index == 96) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 1),
        right: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 84 || index == 126) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 80 || index == 128) {
      return const Border(bottom: BorderSide(color: CSSColors.black, width: 1), left: BorderSide(color: CSSColors.black, width: 1));
    } else if (index == 140 || index == 98) {
      return const Border(
        bottom: BorderSide(color: CSSColors.black, width: 1),
        right: BorderSide(color: CSSColors.black, width: 1),
      );
    } else if (index == 6 || index == 7 || index == 8) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 1),
        bottom: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 1),
        right: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 216 || index == 217 || index == 218) {
      return const Border(
        top: BorderSide(color: CSSColors.black, width: 1),
        bottom: BorderSide(color: CSSColors.black, width: 1),
        right: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 120 || index == 105 || index == 90) {
      return const Border(
        right: BorderSide(color: CSSColors.black, width: 1),
        bottom: BorderSide(color: CSSColors.black, width: 1),
        left: BorderSide(color: CSSColors.black, width: 1),
        top: BorderSide(color: CSSColors.black, width: 2),
      );
    } else if (index == 61 ||
        index == 64 ||
        index == 16 ||
        index == 19 ||
        index == 70 ||
        index == 73 ||
        index == 25 ||
        index == 28 ||
        index == 205 ||
        index == 208 ||
        index == 160 ||
        index == 163 ||
        index == 196 ||
        index == 199 ||
        index == 151 ||
        index == 154) {
      return Border.all(
        color: CSSColors.black,
        width: 2,
      );
    } else {
      return Border.all(
        color: CSSColors.black,
        width: 1,
      );
    }
  }

  static BorderRadius? determineBorderRadius(int index) {
    if (isHomeIndex(index)) {
      return AppConstants.appBorderRadius;
    }

    return null;
  }

  static Color getHomeColor(index) {
    if (index == playerOnePieceOneBaseIndex || index == playerOnePieceTwoBaseIndex || index == playerOnePieceThreeBaseIndex || index == playerOnePieceFourBaseIndex) {
      return PlayerConstants.swatchList[0].playerColor;
    }

    if (index == playerTwoPieceOneBaseIndex || index == playerTwoPieceTwoBaseIndex || index == playerTwoPieceThreeBaseIndex || index == playerTwoPieceFourBaseIndex) {
      return PlayerConstants.swatchList[1].playerColor;
    }

    if (index == playerThreePieceOneBaseIndex || index == playerThreePieceTwoBaseIndex || index == playerThreePieceThreeBaseIndex || index == playerThreePieceFourBaseIndex) {
      return PlayerConstants.swatchList[2].playerColor;
    }

    if (index == playerFourPieceOneBaseIndex || index == playerFourPieceTwoBaseIndex || index == playerFourPieceThreeBaseIndex || index == playerFourPieceFourBaseIndex) {
      return PlayerConstants.swatchList[3].playerColor;
    }

    return Colors.transparent;
  }

  static bool isHomeIndex(index) {
    return index == playerOnePieceOneBaseIndex ||
        index == playerOnePieceTwoBaseIndex ||
        index == playerOnePieceThreeBaseIndex ||
        index == playerOnePieceFourBaseIndex ||
        index == playerTwoPieceOneBaseIndex ||
        index == playerTwoPieceTwoBaseIndex ||
        index == playerTwoPieceThreeBaseIndex ||
        index == playerTwoPieceFourBaseIndex ||
        index == playerThreePieceOneBaseIndex ||
        index == playerThreePieceTwoBaseIndex ||
        index == playerThreePieceThreeBaseIndex ||
        index == playerThreePieceFourBaseIndex ||
        index == playerFourPieceOneBaseIndex ||
        index == playerFourPieceTwoBaseIndex ||
        index == playerFourPieceThreeBaseIndex ||
        index == playerFourPieceFourBaseIndex;
  }

  static Board generateBoard() {
    BuildContext context = Get.context!;

    List<Cell> cells = [];
    for (int index = 0; index < boardGridCellCount; index++) {
      cells.add(
        Cell(
          cellColor: determineCellColor(index, context),
          border: determineCellBorder(index),
          borderRadius: determineBorderRadius(index),
          icon: determineCellIcon(index),
          iconColor: determineCellIconColor(index),
          index: index,
        ),
      );
    }
    return Board(cells: cells);
  }
}
