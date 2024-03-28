// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieItemModelAdapter extends TypeAdapter<MovieItemModel> {
  @override
  final int typeId = 1;

  @override
  MovieItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieItemModel(
      mediaList: (fields[4] as List?)?.cast<MediaModel>(),
      overView: fields[5] as String?,
      releaseDate: fields[1] as String?,
      name: fields[0] as String?,
      posterUrl: fields[3] as String?,
      adult: fields[2] as bool?,
      movieId: fields[6] as int?,
      popularity: fields[7] as double?,
      video: fields[8] as bool?,
      genreList: (fields[9] as List?)?.cast<GenreModel>(),
      trailerKey: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieItemModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.releaseDate)
      ..writeByte(2)
      ..write(obj.adult)
      ..writeByte(3)
      ..write(obj.posterUrl)
      ..writeByte(4)
      ..write(obj.mediaList)
      ..writeByte(5)
      ..write(obj.overView)
      ..writeByte(6)
      ..write(obj.movieId)
      ..writeByte(7)
      ..write(obj.popularity)
      ..writeByte(8)
      ..write(obj.video)
      ..writeByte(9)
      ..write(obj.genreList)
      ..writeByte(10)
      ..write(obj.trailerKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
