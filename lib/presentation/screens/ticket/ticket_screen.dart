import 'package:flutter/material.dart';
import 'package:my_theater/data/repositories/data_db_repositories.dart';
import 'package:my_theater/domain/models/booking_detail/booking_detail_model.dart';
import 'package:my_theater/presentation/screens/common/progress_indicator_widget.dart';

import '../../../domain/models/movie_list/movie_item_model.dart';
import '../../helpers/theme_colors.dart';
import '../../utils/colors/app_colors_util.dart';
import '../../utils/size/app_size_utils.dart';
import '../movie_list/movie_item_widget.dart';

class TicketScreen extends StatefulWidget {
  final MovieItemModel movieItemModel;
  final bool? isDetailScreen;
  final int bookingId;
  const TicketScreen({Key? key, required this.movieItemModel,
    required this.bookingId, this.isDetailScreen})
      : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  MovieItemModel? movieItemModel;
  DataDbRepositories? dataDbRepositories;

  @override
  void initState() {
    movieItemModel = widget.movieItemModel;
    dataDbRepositories = DataDbRepositories(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Scaffold(
      backgroundColor: themeColors.getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: themeColors.getBackgroundColor(),
        title: Text("Ticket Details",
          style: TextStyle(
            color: themeColors.getTextColor(),
            fontSize: AppSizeUtils.smallTitleSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: FutureBuilder<BookingDetailModel?>(
        future: dataDbRepositories?.getBookingDetails(widget.bookingId),
        builder: (context, snapshot) {
          if(snapshot.connectionState!=ConnectionState.done)
          {
            return const ProgressIndicatorWidget();
          }
          return ListView(
            children: [
              MovieItemWidget(movieItemModel: movieItemModel!,
                isDetailScreen: widget.isDetailScreen??false,),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text(
                  "Cinema :",
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.smallTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text("${snapshot.data?.cinema??""}, ${snapshot.data?.location??""}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.bodyTextSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.wholePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text(
                  "Timings :",
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.smallTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text(snapshot.data?.time??"",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.bodyTextSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.wholePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text(
                  "Seat Details :",
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.smallTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.singlePadding),
              Padding(
                padding: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
                    right:AppSizeUtils.wholePadding),
                child: Text("${snapshot.data?.seatRow??""} - ${snapshot.data?.seatNumber??""}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyle(
                    color: themeColors.getTextColor(),
                    fontSize: AppSizeUtils.bodyTextSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: AppSizeUtils.wholePadding),
            ],
          );
        }
      ),
    );
  }

}
