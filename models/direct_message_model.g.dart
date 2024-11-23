// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DirectMessageAdapter extends TypeAdapter<DirectMessage> {
  @override
  final int typeId = 5;

  @override
  DirectMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DirectMessage(
      senderName: fields[1] as String,
      content: fields[2] as String,
      date: fields[3] as DateTime,
      contactUuid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DirectMessage obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.senderName)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.contactUuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DirectMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
