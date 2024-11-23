// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendRequestAdapter extends TypeAdapter<FriendRequest> {
  @override
  final int typeId = 2;

  @override
  FriendRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendRequest(
      senderName: fields[1] as String?,
      senderUUID: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FriendRequest obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.senderName)
      ..writeByte(2)
      ..write(obj.senderUUID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
