// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingDetailModelAdapter extends TypeAdapter<BookingDetailModel> {
  @override
  final int typeId = 4;

  @override
  BookingDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingDetailModel(
      cinema: fields[0] as String?,
      seatNumber: fields[3] as String?,
      seatRow: fields[2] as String?,
      time: fields[1] as String?,
      location: fields[4] as String?,
      bookingId: fields[5] as int?,
      movieName: fields[6] as String?,
      movieId: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookingDetailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cinema)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.seatRow)
      ..writeByte(3)
      ..write(obj.seatNumber)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.bookingId)
      ..writeByte(6)
      ..write(obj.movieName)
      ..writeByte(7)
      ..write(obj.movieId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
