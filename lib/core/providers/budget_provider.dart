import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/income_entry.dart';
import '../models/expense_entry.dart';
import '../services/hive_service.dart';

class BudgetProvider extends ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final Uuid _uuid = const Uuid();

  // ── Temporary (unsaved) entries for today ──────────────────
  List<IncomeEntry> _tempIncomes = [];
  List<ExpenseEntry> _tempExpenses = [];

  // ── Persisted entries ──────────────────────────────────────
  List<IncomeEntry> _savedIncomes = [];
  List<ExpenseEntry> _savedExpenses = [];

  // ── Getters ────────────────────────────────────────────────
  List<IncomeEntry> get tempIncomes => List.unmodifiable(_tempIncomes);
  List<ExpenseEntry> get tempExpenses => List.unmodifiable(_tempExpenses);
  List<IncomeEntry> get savedIncomes => List.unmodifiable(_savedIncomes);
  List<ExpenseEntry> get savedExpenses => List.unmodifiable(_savedExpenses);

  // Today's temp totals
  double get tempTotalIncome =>
      _tempIncomes.fold(0, (s, e) => s + e.amount);
  double get tempTotalExpense =>
      _tempExpenses.fold(0, (s, e) => s + e.amount);

  // Monthly totals (current calendar month)
  int get currentYear => DateTime.now().year;
  int get currentMonth => DateTime.now().month;

  List<IncomeEntry> get monthlyIncomes => _savedIncomes
      .where((e) => e.date.year == currentYear && e.date.month == currentMonth)
      .toList();

  List<ExpenseEntry> get monthlyExpenses => _savedExpenses
      .where((e) => e.date.year == currentYear && e.date.month == currentMonth)
      .toList();

  double get totalMonthlyIncome =>
      monthlyIncomes.fold(0, (s, e) => s + e.amount);

  double get totalMonthlyExpense =>
      monthlyExpenses.fold(0, (s, e) => s + e.amount);

  double get monthlyBalance => totalMonthlyIncome - totalMonthlyExpense;

  // ── Analytics ──────────────────────────────────────────────

  /// Expense by category for current month
  Map<String, double> get expenseByCategory {
    final map = <String, double>{};
    for (final e in monthlyExpenses) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }

  /// Income by source for current month
  Map<String, double> get incomeBySource {
    final map = <String, double>{};
    for (final e in monthlyIncomes) {
      map[e.source] = (map[e.source] ?? 0) + e.amount;
    }
    return map;
  }

  /// Most spent category
  String get mostSpentCategory {
    if (expenseByCategory.isEmpty) return 'N/A';
    return expenseByCategory.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Most earned source
  String get mostEarnedSource {
    if (incomeBySource.isEmpty) return 'N/A';
    return incomeBySource.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Daily expenses map: day -> total for current month
  Map<int, double> get dailyExpenses {
    final map = <int, double>{};
    for (final e in monthlyExpenses) {
      map[e.date.day] = (map[e.date.day] ?? 0) + e.amount;
    }
    return map;
  }

  /// Daily incomes map: day -> total for current month
  Map<int, double> get dailyIncomes {
    final map = <int, double>{};
    for (final e in monthlyIncomes) {
      map[e.date.day] = (map[e.date.day] ?? 0) + e.amount;
    }
    return map;
  }

  /// Average daily spending
  double get averageDailySpending {
    final days = dailyExpenses.length;
    if (days == 0) return 0;
    return totalMonthlyExpense / days;
  }

  // ── Today's saved entries ──────────────────────────────────
  List<IncomeEntry> get todaysSavedIncomes {
    final today = DateTime.now();
    return _savedIncomes
        .where((e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day)
        .toList();
  }

  List<ExpenseEntry> get todaysSavedExpenses {
    final today = DateTime.now();
    return _savedExpenses
        .where((e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day)
        .toList();
  }

  // ── Load from Hive ─────────────────────────────────────────
  void loadFromStorage() {
    _savedIncomes = _hiveService.getAllIncomes();
    _savedExpenses = _hiveService.getAllExpenses();
    notifyListeners();
  }

  // ── Add temp entries ───────────────────────────────────────
  void addTempIncome({
    required double amount,
    required String source,
    required String description,
  }) {
    _tempIncomes.add(IncomeEntry(
      id: _uuid.v4(),
      amount: amount,
      source: source,
      description: description,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void addTempExpense({
    required double amount,
    required String category,
    required String description,
  }) {
    _tempExpenses.add(ExpenseEntry(
      id: _uuid.v4(),
      amount: amount,
      category: category,
      description: description,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void removeTempIncome(String id) {
    _tempIncomes.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void removeTempExpense(String id) {
    _tempExpenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ── Submit Day ─────────────────────────────────────────────
  Future<void> submitDay() async {
    await _hiveService.saveAllIncomes(_tempIncomes);
    await _hiveService.saveAllExpenses(_tempExpenses);
    _savedIncomes.addAll(_tempIncomes);
    _savedExpenses.addAll(_tempExpenses);
    _tempIncomes = [];
    _tempExpenses = [];
    notifyListeners();
  }

  // ── Delete saved entries ───────────────────────────────────
  Future<void> deleteSavedIncome(String id) async {
    await _hiveService.deleteIncome(id);
    _savedIncomes.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  Future<void> deleteSavedExpense(String id) async {
    await _hiveService.deleteExpense(id);
    _savedExpenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ── Monthly reset ──────────────────────────────────────────
  Future<void> resetMonth() async {
    await _hiveService.clearAll();
    _savedIncomes = [];
    _savedExpenses = [];
    _tempIncomes = [];
    _tempExpenses = [];
    notifyListeners();
  }
}
