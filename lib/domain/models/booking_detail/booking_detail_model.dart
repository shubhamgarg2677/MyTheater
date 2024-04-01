
import 'package:hive/hive.dart';

part 'booking_detail_model.g.dart';

@HiveType(typeId: 4)
class BookingDetailModel extends HiveObject{
  @HiveField(0)
  String? cinema;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? seatRow;
  @HiveField(3)
  String? seatNumber;
  @HiveField(4)
  String? location;
  @HiveField(5)
  int? bookingId;
  @HiveField(6)
  String? movieName;
  @HiveField(7)
  int? movieId;

  BookingDetailModel({
    this.cinema, this.seatNumber, this.seatRow, this.time,
    this.location, this.bookingId, this.movieName, this.movieId
  });
}