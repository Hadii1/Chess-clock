// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_timing_podo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomTimingAdapter extends TypeAdapter<CustomTiming> {
  @override
  final typeId = 1;

  @override
  CustomTiming read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomTiming(
      clockName: fields[0] as String,
      atimeHours: fields[1] as int,
      atimeMins: fields[2] as int,
      atimeSec: fields[3] as int,
      aInc: fields[6] as int,
      aDelay: fields[9] as int,
      btimeHours: fields[10] as int,
      btimeMins: fields[11] as int,
      btimeSec: fields[12] as int,
      bInc: fields[15] as int,
      bDelay: fields[18] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CustomTiming obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.clockName)
      ..writeByte(1)
      ..write(obj.atimeHours)
      ..writeByte(2)
      ..write(obj.atimeMins)
      ..writeByte(3)
      ..write(obj.atimeSec)
      ..writeByte(6)
      ..write(obj.aInc)
      ..writeByte(9)
      ..write(obj.aDelay)
      ..writeByte(10)
      ..write(obj.btimeHours)
      ..writeByte(11)
      ..write(obj.btimeMins)
      ..writeByte(12)
      ..write(obj.btimeSec)
      ..writeByte(15)
      ..write(obj.bInc)
      ..writeByte(18)
      ..write(obj.bDelay);
  }
}
