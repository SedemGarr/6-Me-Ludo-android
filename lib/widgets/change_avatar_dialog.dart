import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/animation_wrapper.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';

showChangeAvatarDialog({
  required BuildContext context,
  required List<String> avatarList,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      UserProvider userProvider = context.watch<UserProvider>();

      return AlertDialog(
        shape: AppConstants.appShape,
        contentPadding: EdgeInsets.zero,
        title: Text(
          DialogueService.changeAvatarText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: UserAvatarWidget(
                avatar: userProvider.getUserAvatar(),
                backgroundColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).colorScheme.onSurface,
                shouldExpand: true,
                hasLeftGame: false,
              ),
            ),
            const Divider(),
            SizedBox(
              height: AppConstants.changeAvatarGridviewHeight,
              width: Get.width,
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: avatarList.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 4,
                      position: index,
                      duration: AppConstants.animationDuration,
                      child: CustomAnimationWidget(
                        child: GestureDetector(
                          onTap: () {
                            userProvider.setAvatar(avatarList[index]);
                          },
                          child: UserAvatarWidget(
                            avatar: avatarList[index],
                            backgroundColor: userProvider.isAvatarSelected(avatarList[index]) ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
                            borderColor: Theme.of(context).colorScheme.onSurface,
                            hasLeftGame: false,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
