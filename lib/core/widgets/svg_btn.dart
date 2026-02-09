import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';

class SvgBtn extends StatelessWidget {
  final String asset;
  final VoidCallback onPress;
  const SvgBtn({super.key, required this.asset, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: SvgPicture.asset(
        asset,
        colorFilter: const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
        height: 20,
        width: 20,
      ),
    );
  }
}
