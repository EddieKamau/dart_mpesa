// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpesa_token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MpesaTokenModelAdapter extends TypeAdapter<MpesaTokenModel> {
  @override
  final int typeId = 0;

  @override
  MpesaTokenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MpesaTokenModel(
      fields[0] as String?,
      fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MpesaTokenModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.expires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MpesaTokenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
