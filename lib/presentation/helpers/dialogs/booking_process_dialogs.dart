import 'package:flutter/material.dart';
import 'package:my_theater/domain/models/booking_detail/booking_detail_model.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';

import '../../../data/repositories/data_db_repositories.dart';
import '../../screens/common/choose_option_screen.dart';
import '../../screens/common/payment_done_screen.dart';
import '../../screens/select_seat/seat_select.dart';
import '../../screens/ticket/ticket_screen.dart';

class BookingProcessDialogs {
  MovieItemModel? movieItemModel;
  List<String> cinemaList = const [
    "Omaax",
    "Ambience",
    "DLF",
    "Spice",
    "Wave",
    "PVR"
  ];
  List<String> timeList = const [
    "10:00",
    "12:00",
    "2:00",
    "4:00",
    "6:00",
    "8:00",
    "10:00"
  ];
  BookingDetailModel bookingDetailModel = BookingDetailModel();

  BookingProcessDialogs(this.movieItemModel);

  void chooseCinemaDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            child: ChooseOptionScreen(
                onConfirm: (index) {
                  if(index!=null){
                    onClickConfirmCinema(index, context);
                  }
                },
                hintText: "Choose Cinema",
                titleText: "Choose your Cinema :",
                dataList: cinemaList)),
      );
    });
  }

  void chooseTimingDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            child: ChooseOptionScreen(
                onConfirm: (index) {
                  if(index!=null){
                    onClickConfirmTime(index, context);
                  }
                },
                hintText: "Choose Cinema Time",
                titleText: "Choose your Timing:",
                dataList: timeList)),
      );
    });
  }

  void chooseSeatDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(child: SelectSeatScreen(
          onConfirm: (row, seat) {
            if(row!=null && seat!=null){
              bookingDetailModel.seatRow = row;
              bookingDetailModel.seatNumber =  seat;
              onClickConfirmSeat(context);
            }
          },
        )),
      );
    });
  }

  void paymentDoneDialog(BuildContext context, int bookingId) {
    if(movieItemModel!=null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const Dialog(
            child: PaymentDoneScreen(),
          ),
        ).timeout(const Duration(seconds: 3), onTimeout: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TicketScreen(
                    movieItemModel: movieItemModel!,
                    bookingId: bookingId,
                    isDetailScreen:
                    movieItemModel!.trailerKey != null ? true : false,
                  )));
        });
      });
    }
  }

  void onClickConfirmCinema(int index, BuildContext context) {
    bookingDetailModel.cinema = cinemaList[index];
    bookingDetailModel.movieName = movieItemModel?.name;
    bookingDetailModel.movieId = movieItemModel?.movieId;
    Navigator.pop(context);
    chooseTimingDialog(context);
  }

  void onClickConfirmTime(int index, BuildContext context) {
    bookingDetailModel.time = timeList[index];
    Navigator.pop(context);
    chooseSeatDialog(context);
  }

  Future<void> onClickConfirmSeat(BuildContext context) async {
    Navigator.pop(context);
    DataDbRepositories dataDbRepositories = DataDbRepositories(null);
    int? bookingId = await dataDbRepositories.setBookingDetails(bookingDetailModel);
    if(bookingId!=null && context.mounted){
      paymentDoneDialog(context, bookingId);
    }
  }
}
