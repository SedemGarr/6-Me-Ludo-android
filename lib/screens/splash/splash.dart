import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/splash/widgets/animation_attribution.dart';

import '../../constants/app_constants.dart';
import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_animated_crossfade.dart';
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
    appProvider.initialiseController(tickerProvider);
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
  void dispose() {
    appProvider.disposeLottieController();
    super.dispose();
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
                          child: CustomAnimatedCrossFade(
                            firstChild: Lottie.asset(
                              controller: appProvider.lottieController,
                              AppConstants.wayyyOutLottieAssetPath,
                              onLoaded: (LottieComposition p0) {
                                appProvider.setSplashScreenLoaded(true);
                                // appProvider.lottieController
                                //   ..duration = AppConstants.lottieDuration
                                //   ..animateTo(
                                //     AppConstants.lottieAnimationCutoffPoint,
                                //   ).whenComplete(() => userProvider.completeInit( appProvider, soundProvider));
                                appProvider.lottieController
                                  ..duration = AppConstants.lottieDuration
                                  ..repeat();
                              },
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                            secondChild: const SizedBox(),
                            condition: appProvider.isSplashScreenLoaded,
                          ),
                        ),
                      ),
                      WayOutWidget(width: MediaQuery.of(context).size.width * 0.8),
                      const Spacer(),
                      // Expanded(
                      //   child: appProvider.shouldShowAuthButton && !appProvider.isLoading
                      //       ? Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             SizedBox(
                      //               width: Get.width * 2 / 4,
                      //               child: CustomElevatedButton(
                      //                   onPressed: () {
                      //                     showAuthDialog(context: context);
                      //                   },
                      //                   text: DialogueService.beginText.tr),
                      //             ),
                      //           ],
                      //         )
                      //       : Container(),
                      // ),
                      const AnimationAttributionWidget()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
