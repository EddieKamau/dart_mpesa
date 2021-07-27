// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpesa_token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MpesaTokenTypeAdapter extends TypeAdapter<MpesaTokenType> {
  @override
  final int typeId = 1;

  @override
  MpesaTokenType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MpesaTokenType.normal;
      case 1:
        return MpesaTokenType.stk;
      default:
        return MpesaTokenType.normal;
    }
  }

  @override
  void write(BinaryWriter writer, MpesaTokenType obj) {
    switch (obj) {
      case MpesaTokenType.normal:
        writer.writeByte(0);
        break;
      case MpesaTokenType.stk:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MpesaTokenTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
