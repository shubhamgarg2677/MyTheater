import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_theater/presentation/screens/common/action_button.dart';
import 'package:my_theater/presentation/screens/common/progress_indicator_widget.dart';
import 'package:my_theater/presentation/screens/movie_detail/movie_more_details_widget.dart';
import 'package:my_theater/presentation/screens/movie_list/movie_item_widget.dart';

import '../../../data/remote/api_service.dart';
import '../../../data/repositories/data_db_repositories.dart';
import '../../../domain/models/movie_list/movie_item_model.dart';
import '../../helpers/dialogs/booking_process_dialogs.dart';
import '../../helpers/theme_colors.dart';
import '../../utils/colors/app_colors_util.dart';
import '../../utils/size/app_size_utils.dart';
import '../../utils/text/app_text_utils.dart';
import '../error/network_error_screen.dart';
import '../ticket/ticket_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieItemModel movieItemModel;
  const MovieDetailScreen({Key? key, required this.movieItemModel})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ThemeColors? themeColors;
  MovieItemModel? movieItemModel;
  ApiService apiService = ApiService();

  @override
  void initState() {
    movieItemModel = widget.movieItemModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeColors = ThemeColors(context);
    return Scaffold(
      backgroundColor: themeColors!.getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: themeColors!.getBackgroundColor(),
        title: Text(
          "Details",
          style: TextStyle(
            color: themeColors!.getTextColor(),
            fontSize: AppSizeUtils.smallTitleSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: FutureBuilder<MovieItemModel?>(
        future: DataDbRepositories(apiService).getMovieDetails(movieItemModel!.movieId!),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.data!=null){
            movieItemModel = snapshot.data;
          } else if(snapshot.connectionState == ConnectionState.done){
            return const NetworkErrorScreen(errorText: AppTextUtils.errorText);
          }
          return ListView(
            children: [
              MovieItemWidget(
                movieItemModel: movieItemModel!,
                isDetailScreen: true,
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizeUtils.wholePadding,
                    right: AppSizeUtils.wholePadding),
                child: Text(
                  "Popularity :",
                  style: TextStyle(
                    color: themeColors!.getTextColor(),
                    fontSize: AppSizeUtils.smallTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizeUtils.wholePadding,
                    right: AppSizeUtils.wholePadding),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RatingBarIndicator(
                      rating: (movieItemModel?.popularity??1.0)/2,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: AppColorsUtils.ratingColor,
                        );
                      },
                      itemCount: 5,
                      itemSize: AppSizeUtils.titleSize,
                      direction: Axis.horizontal,
                      unratedColor: AppColorsUtils.disabledColor,
                    ),
                    const SizedBox(width: AppSizeUtils.wholePadding,),
                    Text("( ${((movieItemModel?.popularity??1.0)/2).toStringAsFixed(2)} / 5.0 )",
                      style: TextStyle(
                        color: themeColors!.getTextColor(),
                        fontSize: AppSizeUtils.bodyTextSize,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizeUtils.wholePadding),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizeUtils.wholePadding,
                    right: AppSizeUtils.wholePadding),
                child: Text(
                  "Overview :",
                  style: TextStyle(
                    color: themeColors!.getTextColor(),
                    fontSize: AppSizeUtils.smallTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizeUtils.wholePadding,
                    right: AppSizeUtils.wholePadding),
                child: Text(
                  movieItemModel!.overView!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyle(
                    color: themeColors!.getTextColor(),
                    fontSize: AppSizeUtils.bodyTextSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.wholePadding),
              _getMoreDetailsWidget(),
            ],
          );
        }
      ),
      bottomNavigationBar: ActionButton(
        actionTitle: "Book Ticket",
        onClick: () async{
          if(movieItemModel?.trailerKey != null){
            int? bookingId = await BookingProcessDialogs(movieItemModel).chooseCinemaDialog(context);
            if(bookingId!=null && context.mounted){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => TicketScreen(
                    movieItemModel: movieItemModel!,
                    bookingId: bookingId,
                    isDetailScreen:
                    movieItemModel!.trailerKey != null ? true : false,
                  ),),
              );
            }
          } else{
            Fluttertoast.showToast(
                msg: "Please till details are loading",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColorsUtils.darkBackColor,
                textColor: Colors.white,
                fontSize: AppSizeUtils.bodyTextSize
            );
          }
        },
      ),
    );
  }

  Widget _getMoreDetailsWidget() {
    if (movieItemModel?.trailerKey != null) {
      return MovieMoreDetailsWidget(movieItemModel: movieItemModel!);
    } else {
      return const ProgressIndicatorWidget();
    }
  }

}
