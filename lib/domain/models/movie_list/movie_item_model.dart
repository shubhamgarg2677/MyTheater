import 'package:hive/hive.dart';
import 'package:my_theater/domain/models/movie_detail/media_model.dart';

import '../movie_detail/genre_model.dart';

part 'movie_item_model.g.dart';

@HiveType(typeId: 1)
class MovieItemModel {
  @HiveField(0)
  final String?
      name; //= "My Movie Name My Movie Name My Movie Name My Movie Name";
  @HiveField(1)
  final String? releaseDate; // = "12/12/2012";
  //final String? genre;// = "Action | Thriller";
  @HiveField(2)
  final bool? adult; // = "Adult Certified";
  @HiveField(3)
  final String?
      posterUrl; // = "https://image.tmdb.org/t/p/w1280/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg";
  @HiveField(4)
  final List<MediaModel>?
      mediaList; // = ["https://image.tmdb.org/t/p/w1280/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg"];
  @HiveField(5)
  final String?
      overView; // = "Ex-UFC fighter Dalton takes a job as a bouncer at a Florida Keys roadhouse, only to discover that this paradise is not all it seems.";
  @HiveField(6)
  final int? movieId; // = 0;
  @HiveField(7)
  final double? popularity;
  @HiveField(8)
  final bool? video;
  @HiveField(9)
  final List<GenreModel>? genreList;
  @HiveField(10)
  final String? trailerKey;

  const MovieItemModel(
      {this.mediaList,
      this.overView,
      this.releaseDate,
      this.name,
      this.posterUrl,
      this.adult,
      this.movieId,
      this.popularity,
      this.video,
      this.genreList,
      this.trailerKey});

  factory MovieItemModel.fromJson(dynamic map) {
    return MovieItemModel(
      movieId: map["id"] as int,
      name: map["title"] as String,
      overView: map["overview"] as String,
      adult: map["adult"] as bool,
      posterUrl: map["poster_path"] as String,
      releaseDate: map["release_date"] as String,
      popularity: map["vote_average"] as double,
      video: map["video"] as bool,
      genreList: map["genres"] != null
          ? List<GenreModel>.from((map["genres"] as List)
              .map((model) => GenreModel.fromJson(model)))
          : null,
      trailerKey: map["videos"]!=null && map["videos"]["results"] != null
          ? (map["videos"]["results"] as List).firstWhere((element) => element["type"]=="Trailer" && element["site"]=="YouTube", orElse: () => {"Key":""})["key"] as String
          : null,
      mediaList: map["images"]!=null && map["images"]["posters"] != null
          ? List<MediaModel>.from((map["images"]["posters"] as List).take(5)
              .map((model) => MediaModel.fromJson(model)))
          : null,
    );
  }
}
