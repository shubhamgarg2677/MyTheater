import 'package:flutter/material.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/size/app_size_utils.dart';

class TrailerPlayerScreen extends StatelessWidget {
  final String trailerKey;
  const TrailerPlayerScreen({Key? key, required this.trailerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors.getBackgroundColor(),
        title: Text(
          "Movie Trailer",
          style: TextStyle(
            color: themeColors.getTextColor(),
            fontSize: AppSizeUtils.smallTitleSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: YoutubePlayerBuilder(
          player: getPlayer(),
          builder: (_,player){
            return Container(
              color: AppColorsUtils.blackColor,
              child: Center(
                child: player,
              ),
            );
          },
      ),
    );
  }

  YoutubePlayer getPlayer(){
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: trailerKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColorsUtils.appColor,
      progressColors: ProgressBarColors(
        backgroundColor: AppColorsUtils.disabledColor,
        bufferedColor: AppColorsUtils.lightBackColor,
        playedColor: AppColorsUtils.appColor,
        handleColor: AppColorsUtils.appColor,
      ),
      bottomActions: [
        FullScreenButton(
          controller: controller,
        ),
        PlayPauseButton(
          controller: controller,
        ),
        CurrentPosition(
          controller: controller,
        ),
        ProgressBar(controller: controller, isExpanded: true,
          colors: ProgressBarColors(
            backgroundColor: AppColorsUtils.disabledColor,
            bufferedColor: AppColorsUtils.lightBackColor,
            playedColor: AppColorsUtils.appColor,
            handleColor: AppColorsUtils.appColor,
          ),
        ),
      ],
      onReady: () {
        //controller.addListener(listener);
      },
    );
  }
}
