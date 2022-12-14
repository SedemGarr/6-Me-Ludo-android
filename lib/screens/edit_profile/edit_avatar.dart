import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/appbar/custom_appbar.dart';

import '../../constants/app_constants.dart';
import '../../providers/user_provider.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/text/banner_widget.dart';
import '../../widgets/user/user_avatar_widget.dart';
import '../../widgets/wrappers/animation_wrapper.dart';
import '../../widgets/appbar/app_bar_title_widget.dart';

import '../../widgets/buttons/custom_elevated_button.dart';

class EditAvatarScreen extends StatefulWidget {
  const EditAvatarScreen({super.key});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    userProvider.intialiseAvatarList(false);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    List<String> avatarList = userProvider.avatarList;

    return WillPopScope(
      onWillPop: () async {
        userProvider.setAvatar(userProvider.selectedAvatar);
        NavigationService.genericGoBack();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBarWidget(
          leading: BackButtonWidget(onPressed: () {
            userProvider.setAvatar(userProvider.selectedAvatar);
            NavigationService.genericGoBack();
          }),
          title: AppBarTitleWidget(text: DialogueService.changeAvatarText.tr),
        ),
        body: Column(
          children: [
            BannerWidget(
              text: DialogueService.changeAvatarBannerText.tr,
            ),
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  padding: AppConstants.listViewPadding,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
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
                            userProvider.setSelectedAvatar(avatarList[index]);
                          },
                          child: UserAvatarWidget(
                            avatar: avatarList[index],
                            backgroundColor: userProvider.isAvatarSelected(avatarList[index]) ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
                            borderColor: Theme.of(context).colorScheme.onBackground,
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
        bottomSheet: Container(
          width: Get.width,
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            onPressed: () {
              userProvider.intialiseAvatarList(true);
            },
            text: DialogueService.refreshAvatarText.tr,
          ),
        ),
      ),
    );
  }
}
