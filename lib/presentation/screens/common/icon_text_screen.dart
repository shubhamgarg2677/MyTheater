import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';

import '../../helpers/theme_colors.dart';
import '../../utils/colors/app_colors_util.dart';

class IconTextScreen extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSplashScreen;
  final Color? iconColor;
  const IconTextScreen({Key? key, required this.icon,
    required this.text, required this.isSplashScreen, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Container(
      color: themeColors.getBackgroundColor(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColorsUtils.appColor,
              size: 80,
            ),
            const SizedBox(height: AppSizeUtils.wholePadding),
            Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeColors.getTextColor(),
                fontSize: isSplashScreen
                    ? AppSizeUtils.titleSize
                    : AppSizeUtils.smallTitleSize,
                fontWeight: isSplashScreen
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
