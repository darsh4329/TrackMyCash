import 'package:hive/hive.dart';

part 'income_entry.g.dart';

@HiveType(typeId: 0)
class IncomeEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String source; // Salary, Freelance, Other

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime date;

  IncomeEntry({
    required this.id,
    required this.amount,
    required this.source,
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
        'source': source,
        'description': description,
        'date': date.toIso8601String(),
      };
}
