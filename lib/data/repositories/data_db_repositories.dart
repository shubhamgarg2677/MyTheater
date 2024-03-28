import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_theater/data/repositories/data_api_repositories.dart';
import 'package:my_theater/domain/models/booking_detail/booking_detail_model.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/utils/connection_string.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/db_repositories.dart';
import '../remote/api_service.dart';
import 'local_session.dart';

class DataDbRepositories extends DbRepositories{
  final ApiService? _apiService;

  DataDbRepositories(this._apiService);

  @override
  Future<MovieItemModel?> getMovieDetails(int movieId) async {
    try{
      MovieItemModel? movieItemModel;
      Box<MovieItemModel> movieDetailBox = await Hive.openBox<MovieItemModel>(ConnectionString.movieDetailBox);
      if(movieDetailBox.containsKey(movieId)) {
        movieItemModel = movieDetailBox.get(movieId);
      }
      else{
        movieItemModel = await DataApiRepositories(_apiService).getMovieDetails(movieId);
        if(movieItemModel!=null){
          movieDetailBox.put(movieItemModel.movieId, movieItemModel);
        }
      }
      await movieDetailBox.close();
      return movieItemModel;
    }
    catch(e,s){
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<List<MovieItemModel>?> getUpcomingMovies() async {
    try{
      List<MovieItemModel>? movieItemsList;
      Box moviesListBox = await Hive.openBox(ConnectionString.moviesListBox);
      if(moviesListBox.containsKey("MoviesList")) {
        var dataList = moviesListBox.get("MoviesList");
        movieItemsList = List<MovieItemModel>.from(dataList);
      }
      else{
        movieItemsList = await DataApiRepositories(_apiService).getUpcomingMovies();
        if(movieItemsList!=null){
          moviesListBox.put("MoviesList", movieItemsList);
        }
      }
      await moviesListBox.close();
      return movieItemsList;
    }
    catch(e,s){
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<BookingDetailModel?> getBookingDetails(int bookingId) async {
    try{
      BookingDetailModel? bookingDetailModel;
      Map<int, BookingDetailModel>? bookingDetailItemsList = await getBookingsList();
      if(bookingDetailItemsList!=null && bookingDetailItemsList.containsKey(bookingId)){
        bookingDetailModel = bookingDetailItemsList[bookingId];
      }
      return bookingDetailModel;
    }
    catch(e,s){
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<int?> setBookingDetails(BookingDetailModel bookingDetailModel) async {
    try{
      Box bookingsListBox = await Hive.openBox(ConnectionString.bookingDetailsBox);
      bookingDetailModel.location = LocalSession().currentLocation;
      if(bookingsListBox.containsKey("BookingDetails")){
        Map<int, BookingDetailModel>? bookingDetailItemsList = Map<int, BookingDetailModel>.from(bookingsListBox.get("BookingDetails"));
        bookingDetailModel.bookingId = bookingDetailItemsList.length + 1;
        bookingDetailItemsList.putIfAbsent(bookingDetailModel.bookingId!, () => bookingDetailModel);
        bookingsListBox.put("BookingDetails", bookingDetailItemsList);
      } else{
        bookingDetailModel.bookingId = 1;
        bookingsListBox.put("BookingDetails", {bookingDetailModel.bookingId, bookingDetailModel});
      }
      await bookingsListBox.close();
      return bookingDetailModel.bookingId;
    }
    catch(e,s){
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<Map<int, BookingDetailModel>?> getBookingsList() async {
    Map<int, BookingDetailModel>? bookingDetailItemsList;
    try{
      Box bookingsListBox = await Hive.openBox(ConnectionString.bookingDetailsBox);
      if(bookingsListBox.containsKey("BookingDetails")) {
        bookingDetailItemsList = Map<int, BookingDetailModel>.from(bookingsListBox.get("BookingDetails"));
      }
      await bookingsListBox.close();
    }
    catch(e,s){
      debugPrint(e.toString());
    }
    return bookingDetailItemsList;
  }
}