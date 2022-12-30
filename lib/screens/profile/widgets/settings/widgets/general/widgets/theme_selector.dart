import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/appbar/custom_appbar.dart';

import '../../../../../../../constants/app_constants.dart';
import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../providers/theme_provider.dart';
import '../../../../../../../providers/user_provider.dart';
import '../../../../../../../services/navigation_service.dart';
import '../../../../../../../widgets/wrappers/animation_wrapper.dart';

import '../../../../../../../widgets/appbar/app_bar_title_widget.dart';
import '../../../../../../../widgets/buttons/random_theme_button.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const BackButtonWidget(onPressed: NavigationService.genericGoBack),
        title: AppBarTitleWidget(text: userProvider.getThemeName()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemCount: FlexColor.schemes.keys.toList().length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 4,
                child: CustomAnimationWidget(
                  child: GestureDetector(
                    onTap: () {
                      if (userProvider.isThemeSelected(themeProvider.getSettingsColorListNameByIndex(index))) {
                        userProvider.setThemeToRandom(context);
                      } else {
                        userProvider.setCustomTheme(FlexColor.schemes.keys.toList()[index], context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeProvider.getSettingsColorListByIndex(FlexColor.schemes.keys.toList()[index], userProvider.getUserDarkMode()),
                        borderRadius: AppConstants.appBorderRadius,
                      ),
                      child: userProvider.isThemeSelected(themeProvider.getSettingsColorListNameByIndex(index))
                          ? Icon(
                              AppIcons.themeSelectedIcon,
                              color: ThemeProvider.getContrastingColor(
                                  themeProvider.getSettingsColorListByIndex(FlexColor.schemes.keys.toList()[index], userProvider.getUserDarkMode())),
                            )
                          : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomSheet: const RandomThemeButtonWidget(),
    );
  }
}
