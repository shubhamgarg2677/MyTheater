import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';

abstract class ApiRepositories{
  Future<List<MovieItemModel>?> getUpcomingMovies();

  Future<MovieItemModel?> getMovieDetails(int movieId);
}