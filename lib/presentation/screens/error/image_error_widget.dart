import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.local_movies_outlined,
        size: AppSizeUtils.bigIconSize,
        color: AppColorsUtils.disabledColor,
      ),
    );
  }
}
