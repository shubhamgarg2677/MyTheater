import 'package:flutter/material.dart';

import '../../utils/colors/app_colors_util.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: AppColorsUtils.appColor,
          backgroundColor: AppColorsUtils.disabledColor,
        ),
      ),
    );
  }
}
