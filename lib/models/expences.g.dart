// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenceModeAdapter extends TypeAdapter<ExpenceMode> {
  @override
  final int typeId = 1;

  @override
  ExpenceMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenceMode(
      title: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      category: fields[4] as Category,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenceMode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenceModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
