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
                  child: ListView.separated(
                      padding: AppConstants.listViewPadding,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: licenses.length,
                      itemBuilder: (BuildContext context, int index) {
                        License license = licenses[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: AppConstants.animationDuration,
                          child: CustomAnimationWidget(
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                iconColor: Theme.of(context).colorScheme.primary,
                                collapsedIconColor: Theme.of(context).primaryColor,
                                title: Text(
                                  license.title,
                                  style: TextStyles.legalTextStyleBold(Theme.of(context).colorScheme.onSurface),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 24,
                                    ),
                                    child: Text(license.text, style: TextStyles.legalTextStyleNormal(Theme.of(context).colorScheme.onSurface)),
                                  )
                                ],
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
