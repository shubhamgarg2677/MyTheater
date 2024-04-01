import '../models/booking_detail/booking_detail_model.dart';
import '../models/movie_list/movie_item_model.dart';

abstract class DbRepositories{
  Future<List<MovieItemModel>?> getUpcomingMovies();
  Future<MovieItemModel?> getMovieDetails(int movieId);
  Future<MovieItemModel?> getMovieItem(int movieId);
  Future<Map<int, BookingDetailModel>?> getBookingsList();
  Future<BookingDetailModel?> getBookingDetails(int bookingId);
  Future<int?> setBookingDetails(BookingDetailModel bookingDetailModel);
}