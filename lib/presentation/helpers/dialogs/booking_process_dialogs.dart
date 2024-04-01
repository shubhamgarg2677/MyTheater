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
    "11:00",
    "12:00",
    "2:00",
    "4:00",
    "6:00",
    "8:00",
    "9:00"
  ];
  BookingDetailModel bookingDetailModel = BookingDetailModel();
  int? bookingId;

  BookingProcessDialogs(this.movieItemModel);

  Future<int?> chooseCinemaDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          child: ChooseOptionScreen(
              onConfirm: (index) {
                if(index!=null){
                  _onClickConfirmCinema(index, context);
                }
              },
              hintText: "Choose Cinema",
              titleText: "Choose your Cinema :",
              dataList: cinemaList)),
    );
    return bookingId;
  }

  void _chooseTimingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          child: ChooseOptionScreen(
              onConfirm: (index) {
                if(index!=null){
                  _onClickConfirmTime(index, context);
                }
              },
              hintText: "Choose Cinema Time",
              titleText: "Choose your Timing:",
              dataList: timeList)),
    );
  }

  void _chooseSeatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(child: SelectSeatScreen(
        onConfirm: (row, seat) {
          if(row!=null && seat!=null){
            bookingDetailModel.seatRow = row;
            bookingDetailModel.seatNumber =  seat;
            _onClickConfirmSeat(context);
          }
        },
      )),
    );
  }

  Future<void> _paymentDoneDialog(BuildContext context, int bookingId) async {
    if(movieItemModel!=null){
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const Dialog(
          child: PaymentDoneScreen(),
        ),
      ).timeout(const Duration(seconds: 3), onTimeout: (){
        if(context.mounted){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
              builder: (context) => TicketScreen(
                movieItemModel: movieItemModel!,
                bookingId: bookingId,
                isDetailScreen:
                movieItemModel!.trailerKey != null ? true : false,
              )),
            ModalRoute.withName('/MovieList'),
          );
        }
      });
    }
  }

  void _onClickConfirmCinema(int index, BuildContext context) {
    bookingDetailModel.cinema = cinemaList[index];
    bookingDetailModel.movieName = movieItemModel?.name;
    bookingDetailModel.movieId = movieItemModel?.movieId;
    Navigator.pop(context);
    _chooseTimingDialog(context);
  }

  void _onClickConfirmTime(int index, BuildContext context) {
    bookingDetailModel.time = timeList[index];
    Navigator.pop(context);
    _chooseSeatDialog(context);
  }

  Future<void> _onClickConfirmSeat(BuildContext context) async {
    DataDbRepositories dataDbRepositories = DataDbRepositories(null);
    bookingId = await dataDbRepositories.setBookingDetails(bookingDetailModel);
    if(bookingId!=null && context.mounted){
      _paymentDoneDialog(context, bookingId!);
    }
  }
}
