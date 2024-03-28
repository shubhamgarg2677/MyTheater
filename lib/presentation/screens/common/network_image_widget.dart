import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_theater/presentation/screens/error/image_error_widget.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/utils/connection_string.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final int? cacheWidth;
  final int? cacheHeight;
  const NetworkImageWidget({Key? key, required this.url, this.fit,
    this.cacheHeight, this.cacheWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(url.isEmpty) {
      return const ImageErrorWidget();
    }
    return Image.network(
      url,
      fit: fit,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      loadingBuilder: (_, child, loadingProgress){
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
            color: AppColorsUtils.appColor,
            backgroundColor: AppColorsUtils.disabledColor,
          ),
        );
      },
      errorBuilder: (_, __, st){
        return const ImageErrorWidget();
      },
    );
  }
}
