
import 'package:hive/hive.dart';

part 'media_model.g.dart';

@HiveType(typeId: 2)
class MediaModel{
  @HiveField(0)
  final double? aspectRatio;
  @HiveField(1)
  final String? filePath;
  @HiveField(2)
  final int? height;
  @HiveField(3)
  final int? width;

  const MediaModel({
    this.height, this.width, this.aspectRatio, this.filePath
  });

  factory MediaModel.fromJson(dynamic map){
    return MediaModel(
        aspectRatio: map["aspect_ratio"] as double,
        filePath: map["file_path"] as String,
        width: map["width"] as int,
        height: map["height"] as int,
    );
  }
}