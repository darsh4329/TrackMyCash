// GENERATED CODE - DO NOT MODIFY BY HAND
// Manually written adapter to avoid build_runner requirement.

part of 'income_entry.dart';

class IncomeEntryAdapter extends TypeAdapter<IncomeEntry> {
  @override
  final int typeId = 0;

  @override
  IncomeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeEntry(
      id: fields[0] as String,
      amount: fields[1] as double,
      source: fields[2] as String,
      description: fields[3] as String,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
