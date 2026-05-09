// GENERATED CODE - DO NOT MODIFY BY HAND
// Manually written adapter to avoid build_runner requirement.

part of 'expense_entry.dart';

class ExpenseEntryAdapter extends TypeAdapter<ExpenseEntry> {
  @override
  final int typeId = 1;

  @override
  ExpenseEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseEntry(
      id: fields[0] as String,
      amount: fields[1] as double,
      category: fields[2] as String,
      description: fields[3] as String,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category)
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
      other is ExpenseEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
