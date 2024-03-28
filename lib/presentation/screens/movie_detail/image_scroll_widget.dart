import 'package:flutter/material.dart';
import 'package:my_theater/domain/models/movie_detail/media_model.dart';
import 'package:my_theater/presentation/screens/common/network_image_widget.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';
import 'package:my_theater/utils/connection_string.dart';

import '../common/dot_indicator.dart';

class ImageScrollWidget extends StatelessWidget {
  final List<MediaModel>? urlList;
  const ImageScrollWidget({Key? key, this.urlList}) : super(key: key);

  final double _toolbarExpandedHeight = 240;
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);
    ScrollController listController = ScrollController();
    if(urlList==null) {
      return const SizedBox();
    }
    return SizedBox(
      height: _toolbarExpandedHeight,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize)),
        ),
        color: AppColorsUtils.blackColor,//ThemeColors(context).getBackgroundColor(),
        margin: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
            right: AppSizeUtils.wholePadding),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
                itemCount: urlList!.length,
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NetworkImageWidget(
                    url: ConnectionString.mediaBaseUrl + urlList![index].filePath!,
                    fit: BoxFit.contain,
                  );
                },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.black54,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppSizeUtils.singlePadding),
                child: DotsIndicator(
                  controller: controller,
                  itemCount: urlList!.length,
                  listViewController: listController,
                  onPageSelected: (int page) {
                    controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                    listController.animateTo(page.toDouble(),
                        duration: _kDuration, curve: _kCurve);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
