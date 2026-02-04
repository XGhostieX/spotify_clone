import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/assets.dart';
import 'home_view.dart';
import 'upload_song_view.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: controller,
      screens: [const HomeView(), const UploadSongView()],
      items: [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(Assets.homeFilled),
          inactiveIcon: SvgPicture.asset(Assets.home),
          title: ("Home"),
          activeColorPrimary: AppColors.gradient2,
          inactiveColorPrimary: AppColors.inactiveBottomBarItemColor,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(Assets.libraryFilled),
          inactiveIcon: SvgPicture.asset(Assets.library),
          title: ("Library"),
          activeColorPrimary: AppColors.gradient2,
          inactiveColorPrimary: AppColors.inactiveBottomBarItemColor,
        ),
      ],
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      // padding: const EdgeInsets.only(top: 8),
      backgroundColor: AppColors.backgroundColor,
      isVisible: true,

      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style6,
    );
  }
}
