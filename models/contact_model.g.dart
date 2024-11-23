// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactDataAdapter extends TypeAdapter<ContactData> {
  @override
  final int typeId = 3;

  @override
  ContactData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactData(
      name: fields[1] as String,
      imageName: fields[3] as String,
      contactUUID: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactData obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contactUUID)
      ..writeByte(3)
      ..write(obj.imageName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
