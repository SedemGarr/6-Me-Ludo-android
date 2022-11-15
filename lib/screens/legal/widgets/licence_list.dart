import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import '../../../constants/app_constants.dart';
import '../../../models/license.dart';
import '../../../utils/utils.dart';
import '../../../widgets/animation_wrapper.dart';
import '../../../widgets/loading_widget.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<License>>(
            future: Utils.loadLicenses(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<License> licenses = snapshot.data!;
                return AnimationLimiter(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 4.0),
                      itemCount: licenses.length,
                      itemBuilder: (BuildContext context, int index) {
                        License license = licenses[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: AppConstants.animationDuration,
                          child: CustomAnimationWidget(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ClipRRect(
                                  borderRadius: AppConstants.appBorderRadius,
                                  child: ExpansionTile(
                                    collapsedBackgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(AppConstants.appOpacity),
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                    iconColor: Theme.of(context).colorScheme.primary,
                                    collapsedIconColor: Theme.of(context).primaryColor,
                                    title: Text(
                                      license.title,
                                      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 24,
                                        ),
                                        child: Text(license.text, style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      ],
    );
  }
}
