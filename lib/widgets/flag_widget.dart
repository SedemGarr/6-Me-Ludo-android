import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

class FlagWidget extends StatelessWidget {
  final String countryCode;
  final Color color;

  const FlagWidget({super.key, required this.countryCode, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.04,
      width: (Get.height * 0.04) * 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: AppConstants.appBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: AppConstants.appBorderRadius,
        child: Flag.fromString(
          countryCode,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
