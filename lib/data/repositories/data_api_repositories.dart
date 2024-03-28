import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_theater/data/remote/api_service.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/domain/repositories/api_repositories.dart';
import 'package:my_theater/utils/connection_string.dart';

class DataApiRepositories extends ApiRepositories{
  final ApiService? _apiService;

  DataApiRepositories(this._apiService);

  @override
  Future<List<MovieItemModel>?> getUpcomingMovies() async {
    String url = ConnectionString.baseUrl + ConnectionString.upcomingUrl;
    Response? response = await _apiService?.getMethod(url);
    if(response?.statusCode==200){
      dynamic json = jsonDecode(response!.body);
      List<MovieItemModel> dataList = [];
      for (var element in (json["results"] as List)) {
        dataList.add(MovieItemModel.fromJson(element));
      }
      return dataList;
    } else{
      return null;
    }
  }

  @override
  Future<MovieItemModel?> getMovieDetails(int movieId) async {
    String url = ConnectionString.baseUrl + movieId.toString();
    Response? response = await _apiService?.getMethodWithParams(url, ConnectionString.fullDetailParams);
    if(response?.statusCode==200){
      dynamic json = jsonDecode(response!.body);
      MovieItemModel movieData = MovieItemModel.fromJson(json);
      return movieData;
    } else{
      return null;
    }
  }

}