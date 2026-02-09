import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/theme/app_colors.dart';
import 'home_view.dart';
import 'upload_song_view.dart';
import 'widgets/music_slab.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: controller,
      screens: [const HomeView(), const UploadSongView()],
      floatingActionButton: const Material(child: MusicSlab()),
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: ("Home"),
          activeColorPrimary: AppColors.whiteColor,
          inactiveColorPrimary: AppColors.inactiveBottomBarItemColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.library_music_rounded),
          inactiveIcon: const Icon(Icons.library_music_outlined),
          title: ("Library"),
          activeColorPrimary: AppColors.whiteColor,
          inactiveColorPrimary: AppColors.inactiveBottomBarItemColor,
        ),
      ],
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.symmetric(vertical: 5),
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
