import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';

class LoadingScreen extends StatefulWidget {
  final String? text;

  const LoadingScreen({super.key, this.text});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late AppProvider appProvider;
  String text = '';

  @override
  void initState() {
    super.initState();
    appProvider = context.read<AppProvider>();
    text = widget.text ?? appProvider.getLoadingString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: AppBarTitleWidget(text: text),
          centerTitle: true,
        ),
        body: LoadingWidget(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
