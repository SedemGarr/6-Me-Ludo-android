import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/splash/widgets/animation_attribution.dart';

import '../../constants/app_constants.dart';
import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/wayout_widget.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late UserProvider userProvider;
  late AppProvider appProvider;

  Future<void> init(BuildContext context, TickerProvider tickerProvider) async {
    await userProvider.initUser(context);
  }

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    appProvider = context.read<AppProvider>();
    init(context, this);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return WillPopScope(
      onWillPop: () async {
        AppProvider.exitApp();
        return false;
      },
      child: Scaffold(
        body: appProvider.isLoading
            ? const LoadingScreen()
            : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppConstants.appBorderRadius,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Lottie.asset(
                            AppConstants.wayyyOutLottieAssetPath,
                            repeat: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      WayOutWidget(width: MediaQuery.of(context).size.width * 0.8),
                      const Spacer(),
                      const AnimationAttributionWidget()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
