// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_musicList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TempMusicListAdapter extends TypeAdapter<TempMusicList> {
  @override
  final int typeId = 0;

  @override
  TempMusicList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TempMusicList()
      ..imageurl = fields[0] as String
      ..title = fields[1] as String
      ..videoId = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, TempMusicList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageurl)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.videoId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempMusicListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
