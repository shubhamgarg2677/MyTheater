
import 'package:hive/hive.dart';

part 'genre_model.g.dart';

@HiveType(typeId: 3)
class GenreModel{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;

  const GenreModel({
    this.id, this.name
  });

  factory GenreModel.fromJson(dynamic map){
    return GenreModel(
        id: map["id"] as int,
        name: map["name"] as String
    );
  }
}