import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';

class MultiAvatarWidget extends StatelessWidget {
  final String avatar;
  final bool isBackgroundTransparent;

  const MultiAvatarWidget({super.key, required this.avatar, required this.isBackgroundTransparent});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      multiavatar(
        avatar,
        trBackground: isBackgroundTransparent,
      ),
    );
  }
}
