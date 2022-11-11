import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/screens/home/widgets/bottom_navbar.dart';
import 'package:six_me_ludo_android/screens/profile/profile.dart';

class HomePageViewWrapper extends StatefulWidget {
  static String routeName = '/HomePageViewWrapper';

  const HomePageViewWrapper({super.key});

  @override
  State<HomePageViewWrapper> createState() => _HomePageViewWrapperState();
}

class _HomePageViewWrapperState extends State<HomePageViewWrapper> {
  late DynamicLinkProvider dynamicLinkProvider;

  @override
  void initState() {
    super.initState();
    dynamicLinkProvider = context.read();
    dynamicLinkProvider.handleDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = context.watch<NavProvider>();

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleHomeWrapperBackPress(context);
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: navProvider.pageController,
          onPageChanged: (index) => navProvider.setBottomNavBarIndex(index, false),
          children: const [
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}
