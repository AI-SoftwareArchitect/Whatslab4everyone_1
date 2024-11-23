// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 4;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      profileImageName: fields[1] as String,
      chatBackgroundImageName: fields[2] as String,
      applyEncryptionForSavedLocalMessages: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.profileImageName)
      ..writeByte(2)
      ..write(obj.chatBackgroundImageName)
      ..writeByte(3)
      ..write(obj.applyEncryptionForSavedLocalMessages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
