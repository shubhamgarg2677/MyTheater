import 'package:flutter/material.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';

import '../../../domain/models/movie_detail/genre_model.dart';
import '../../../utils/connection_string.dart';
import '../../helpers/dialogs/booking_process_dialogs.dart';
import '../../utils/size/app_size_utils.dart';
import '../common/network_image_widget.dart';
import '../movie_detail/movie_detail_screen.dart';
import '../ticket/ticket_screen.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieItemModel movieItemModel;
  final bool isDetailScreen;
  const MovieItemWidget({Key? key, required this.movieItemModel,
    required this.isDetailScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors(context);
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSizeUtils.singlePadding,
          right: AppSizeUtils.wholePadding,
          bottom: AppSizeUtils.singlePadding),
      child: SizedBox(
        height: isDetailScreen ? 206 : 136,
        child: Stack(
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizeUtils.roundCornerSize),
              ),
              onTap: isDetailScreen ? null : (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (_)=>MovieDetailScreen(
                      movieItemModel: movieItemModel,
                    )),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: isDetailScreen ? 206 : 136,
                    width: isDetailScreen ? 137 : 104,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize)),
                      ),
                      color: AppColorsUtils.blackColor,
                      margin: const EdgeInsets.all(AppSizeUtils.singlePadding),
                      clipBehavior: Clip.hardEdge,
                      child: NetworkImageWidget(
                        cacheHeight: isDetailScreen ? 206 : 136,
                        cacheWidth: isDetailScreen ? 137 : 104,
                        url: ConnectionString.imageBaseUrl + (movieItemModel.posterUrl??""),
                        fit: BoxFit.fill,),
                    ),
                  ),
                  const SizedBox(width: AppSizeUtils.singlePadding),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizeUtils.singlePadding/2),
                        Text(
                          movieItemModel.name ?? "",
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            color: colors.getTextColor(),
                            fontSize: isDetailScreen
                                ? AppSizeUtils.midTitleSize
                                : AppSizeUtils.smallTitleSize,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        if(movieItemModel.releaseDate!=null)
                          const SizedBox(height: AppSizeUtils.singlePadding),
                        if(movieItemModel.releaseDate!=null && isDetailScreen)
                          Text(
                            "Release Date :",
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if(movieItemModel.releaseDate!=null)
                          Text(
                            movieItemModel.releaseDate!,
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if(movieItemModel.genreList!=null)
                          const SizedBox(height: AppSizeUtils.singlePadding),
                        if(movieItemModel.genreList!=null && isDetailScreen)
                          Text(
                            "Movie Genres :",
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if(movieItemModel.genreList!=null)
                          Text(_getGenre(movieItemModel.genreList!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        const SizedBox(height: AppSizeUtils.singlePadding),
                        if(movieItemModel.adult!=null && isDetailScreen)
                          Text(
                            "Movie Type :",
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if(movieItemModel.adult!=null)
                          Text(movieItemModel.adult! ? "Adult Movie" : "Not Adult Movie",
                            style: TextStyle(
                              color: colors.getTextColor(),
                              fontSize: AppSizeUtils.bodyTextSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(!isDetailScreen)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSizeUtils.singlePadding,
                    right: AppSizeUtils.singlePadding,
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      int? bookingId = await BookingProcessDialogs(movieItemModel).chooseCinemaDialog(context);
                      if(bookingId!=null && context.mounted){
                        Navigator.pop(context, MaterialPageRoute(
                            builder: (context) => TicketScreen(
                              movieItemModel: movieItemModel,
                              bookingId: bookingId,
                              isDetailScreen:
                              movieItemModel.trailerKey != null ? true : false,
                            )),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColorsUtils.appColor)
                    ),
                    icon: const Icon(Icons.bookmark_outline,
                      color: AppColorsUtils.lightBackColor,
                      size: AppSizeUtils.iconSize,),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getGenre(List<GenreModel> genreList){
    String genre = "";
    for (var element in genreList) {
      genre += "${element.name} | ";
    }
    return genre.substring(0,genre.length-2);
  }
}
