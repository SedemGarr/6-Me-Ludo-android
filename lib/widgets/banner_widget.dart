import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';

class BannerWidget extends StatelessWidget {
  final String text;

  const BannerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.animationDuration,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: AppConstants.bannerPadding,
              child: Text(
                text,
                style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
