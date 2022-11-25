import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';

import '../providers/user_provider.dart';
import 'app_bar_title_widget.dart';

class WelcomeAppbarTitleText extends StatefulWidget {
  const WelcomeAppbarTitleText({super.key});

  @override
  State<WelcomeAppbarTitleText> createState() => _WelcomeAppbarTitleTextState();
}

class _WelcomeAppbarTitleTextState extends State<WelcomeAppbarTitleText> {
  late AppProvider appProvider;
  late String welcomeString;

  @override
  void initState() {
    super.initState();
    appProvider = context.read<AppProvider>();
    welcomeString = appProvider.getWelcomeString();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return AppBarTitleWidget(
      text: welcomeString + userProvider.getUserPseudonym(),
    );
  }
}
