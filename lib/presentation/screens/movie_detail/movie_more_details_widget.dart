import 'package:flutter/material.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';
import 'package:my_theater/presentation/screens/trailer_player/trailer_player_screen.dart';

import '../../../domain/models/movie_list/movie_item_model.dart';
import '../../../utils/connection_string.dart';
import '../../utils/colors/app_colors_util.dart';
import '../../utils/size/app_size_utils.dart';
import '../common/network_image_widget.dart';
import 'image_scroll_widget.dart';

class MovieMoreDetailsWidget extends StatelessWidget {
  final MovieItemModel movieItemModel;
  const MovieMoreDetailsWidget({Key? key, required this.movieItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
              right:AppSizeUtils.wholePadding),
          child: Text(
            "Watch Trailer :",
            style: TextStyle(
              color: themeColors.getTextColor(),
              fontSize: AppSizeUtils.smallTitleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize)),
                ),
                color: AppColorsUtils.blackColor,
                margin: const EdgeInsets.only(
                    left: AppSizeUtils.wholePadding,
                    right: AppSizeUtils.wholePadding,
                    top: AppSizeUtils.singlePadding),
                clipBehavior: Clip.hardEdge,
                child: NetworkImageWidget(url: ConnectionString.imageBaseUrl + (movieItemModel.posterUrl??""),),
              ),
              Center(
                child: IconButton(
                  onPressed: (){onTapTrailer(context);},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black54)
                  ),
                  icon: const Icon(
                    Icons.play_arrow,
                    color: AppColorsUtils.whiteColor,
                    size: AppSizeUtils.bigIconSize,),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizeUtils.wholePadding),
        Padding(
          padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
              right:AppSizeUtils.wholePadding),
          child: Text(
            "Media :",
            style: TextStyle(
              color: themeColors.getTextColor(),
              fontSize: AppSizeUtils.smallTitleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSizeUtils.singlePadding),
        ImageScrollWidget(urlList: movieItemModel.mediaList),
        const SizedBox(height: AppSizeUtils.wholePadding),
      ],
    );
  }

  void onTapTrailer(BuildContext context){
    if(movieItemModel.trailerKey!=null){
      Navigator.push(context,
          MaterialPageRoute(builder: (_)=>TrailerPlayerScreen(
              trailerKey: movieItemModel.trailerKey!),
          ),
      );
    }
  }
}
