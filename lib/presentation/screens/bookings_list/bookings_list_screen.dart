import 'package:flutter/material.dart';
import 'package:my_theater/data/repositories/data_db_repositories.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';
import 'package:my_theater/presentation/screens/common/progress_indicator_widget.dart';
import 'package:my_theater/presentation/screens/ticket/ticket_screen.dart';

import '../../../domain/models/booking_detail/booking_detail_model.dart';
import '../../utils/size/app_size_utils.dart';
import '../common/icon_text_screen.dart';

class BookingsListScreen extends StatefulWidget {
  const BookingsListScreen({Key? key}) : super(key: key);

  @override
  State<BookingsListScreen> createState() => _BookingsListScreenState();
}

class _BookingsListScreenState extends State<BookingsListScreen> {
  DataDbRepositories dataDbRepositories = DataDbRepositories(null);

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Scaffold(
      backgroundColor: themeColors.getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: themeColors.getBackgroundColor(),
        title: Text(
          "Bookings List",
          style: TextStyle(
            color: themeColors.getTextColor(),
            fontSize: AppSizeUtils.smallTitleSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: FutureBuilder<Map<int, BookingDetailModel>?>(
          future: dataDbRepositories.getBookingsList(),
          builder: (context, snap){
            if(snap.connectionState == ConnectionState.done){
              if(snap.data==null || (snap.data?.isEmpty??true)){
                return IconTextScreen(
                  icon: Icons.list_alt_outlined,
                  text: "No Bookings Found",
                  iconColor: themeColors.getTextColor(),
                  isSplashScreen: false,
                );
              }
              else{
                return ListView.builder(
                    itemCount: snap.data?.length,
                    itemBuilder: (context, index){
                      BookingDetailModel? bookingDetailModel = snap.data?.values.toList()[index];
                      return InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppSizeUtils.roundCornerSize),
                        ),
                        onTap: (){
                          onOpenTicket(bookingDetailModel);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSizeUtils.singlePadding/2),
                            Text(
                              bookingDetailModel?.movieName ?? "",
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.smallTitleSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            const SizedBox(height: AppSizeUtils.singlePadding),
                            Text(
                                "Cinema :",
                                style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.bodyTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                                bookingDetailModel?.cinema??"",
                                style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.bodyTextSize,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            const SizedBox(height: AppSizeUtils.singlePadding),
                            Text(
                                "Movie Time :",
                                style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.bodyTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                              bookingDetailModel?.time??"",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: themeColors.getTextColor(),
                                fontSize: AppSizeUtils.bodyTextSize,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: AppSizeUtils.singlePadding),
                            Text(
                                "Movie Seat :",
                                style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.bodyTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                              "${bookingDetailModel?.seatRow??""} - ${bookingDetailModel?.seatNumber??""}",
                                style: TextStyle(
                                  color: themeColors.getTextColor(),
                                  fontSize: AppSizeUtils.bodyTextSize,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                );
              }
            }
            else{
              return const ProgressIndicatorWidget();
            }
          },
      ),
    );
  }

  Future<void> onOpenTicket(BookingDetailModel? bookingDetailModel) async {
    if(bookingDetailModel!=null && bookingDetailModel.movieId!=null && bookingDetailModel.bookingId!=null){
      MovieItemModel? movieItemModel = await dataDbRepositories.getMovieDetails(bookingDetailModel.movieId!);
      if(movieItemModel!=null && mounted){
        Navigator.push(context, MaterialPageRoute(
            builder: (_)=>TicketScreen(
              movieItemModel: movieItemModel,
              bookingId: bookingDetailModel.bookingId!,
              isDetailScreen: true,
            )),
        );
      }
    }
  }
}
