import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

class TitleWidget extends StatelessWidget {
  final double width;
  final Color? color;

  const TitleWidget({Key? key, required this.width, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
        top: 0.0,
      ),
      child: ClipRRect(
        borderRadius: AppConstants.appBorderRadius,
        child: Image.asset(
          AppConstants.appLogoAssetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
