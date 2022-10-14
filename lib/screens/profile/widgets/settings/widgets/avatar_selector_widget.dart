import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/animation_wrapper.dart';
import '../../../../../widgets/user_avatar_widget.dart';

class AvatarSelectionWidget extends StatefulWidget {
  const AvatarSelectionWidget({super.key});

  @override
  State<AvatarSelectionWidget> createState() => _AvatarSelectionWidgetState();
}

class _AvatarSelectionWidgetState extends State<AvatarSelectionWidget> {
  late List<String> avatarList;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    avatarList = Utils.generateAvatarSelectionCodes(userProvider.getUserAvatar());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                avatarList = Utils.generateAvatarSelectionCodes(userProvider.getUserAvatar());
              });
            },
            icon: Icon(
              AppIcons.refreshAvatarListIcon,
              color: Theme.of(context).primaryColor,
            )),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
            child: AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: mounted,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
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
                          setState(() {
                            userProvider.setAvatar(avatarList[index]);
                          });
                        },
                        child: UserAvatarWidget(
                          avatar: avatarList[index],
                          backgroundColor: userProvider.isAvatarSelected(avatarList[index]) ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
                          borderColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
