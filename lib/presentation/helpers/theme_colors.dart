import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';

class ThemeColors{
  final BuildContext buildContext;
  ThemeColors(this.buildContext);

  Color getBackgroundColor()
  {
    return AppColorsUtils.lightBackColor;
  }

  Color getTextColor()
  {
    return AppColorsUtils.blackColor;
  }
}