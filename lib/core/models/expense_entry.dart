import 'package:hive/hive.dart';

part 'expense_entry.g.dart';

@HiveType(typeId: 1)
class ExpenseEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category; // Food, Travel, Shopping, Bills, Other

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime date;

  ExpenseEntry({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String get dayKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'category': category,
        'description': description,
        'date': date.toIso8601String(),
      };
}
