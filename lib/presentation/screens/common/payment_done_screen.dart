import 'package:flutter/material.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';

import '../../utils/colors/app_colors_util.dart';
import '../../utils/size/app_size_utils.dart';

class PaymentDoneScreen extends StatelessWidget {
  const PaymentDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizeUtils.wholePadding*3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline,
            color: AppColorsUtils.appColor,
            size: AppSizeUtils.bigIconSize+AppSizeUtils.bigIconSize,),
          const SizedBox(height: AppSizeUtils.wholePadding),
          Text(
            "Booking Done",
            style: TextStyle(
              color: themeColors.getTextColor(),
              fontSize: AppSizeUtils.midTitleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
