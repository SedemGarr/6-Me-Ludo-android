import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle appBarTitleStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle fabStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle noGamesStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle listTitleStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle listSubtitleStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle chatListSubtitleStyle(Color color, bool isItalic) {
    return TextStyle(
      color: color,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle dialogTitleStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle dialogContentStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle dialogContentStyleBold(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle elevatedButtonStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textButtonStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle settingsHeaderStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textFieldStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle tabbarTextStyle(Color color, bool isBold) {
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static TextStyle popupMenuStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle legalTextStyleNormal(Color color) {
    return GoogleFonts.quantico(
      color: color,
    );
  }

  static TextStyle legalTextStyleBold(Color color) {
    return TextStyle(
      color: color,
    );
  }
}
