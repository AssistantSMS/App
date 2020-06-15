// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingState.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingStateAdapter extends TypeAdapter<SettingState> {
  @override
  final typeId = 2;

  @override
  SettingState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingState(
      selectedLanguage: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.selectedLanguage);
  }
}
