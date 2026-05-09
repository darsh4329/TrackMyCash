import 'package:hive_flutter/hive_flutter.dart';
import '../models/income_entry.dart';
import '../models/expense_entry.dart';

class HiveService {
  static const String _incomesBox = 'incomes';
  static const String _expensesBox = 'expenses';

  // ── Income ──────────────────────────────────────────────────

  Box<IncomeEntry> get _incomes => Hive.box<IncomeEntry>(_incomesBox);
  Box<ExpenseEntry> get _expenses => Hive.box<ExpenseEntry>(_expensesBox);

  Future<void> saveIncome(IncomeEntry entry) async {
    await _incomes.put(entry.id, entry);
  }

  Future<void> saveAllIncomes(List<IncomeEntry> entries) async {
    final map = {for (final e in entries) e.id: e};
    await _incomes.putAll(map);
  }

  List<IncomeEntry> getAllIncomes() {
    return _incomes.values.toList();
  }

  Future<void> deleteIncome(String id) async {
    await _incomes.delete(id);
  }

  // ── Expense ─────────────────────────────────────────────────

  Future<void> saveExpense(ExpenseEntry entry) async {
    await _expenses.put(entry.id, entry);
  }

  Future<void> saveAllExpenses(List<ExpenseEntry> entries) async {
    final map = {for (final e in entries) e.id: e};
    await _expenses.putAll(map);
  }

  List<ExpenseEntry> getAllExpenses() {
    return _expenses.values.toList();
  }

  Future<void> deleteExpense(String id) async {
    await _expenses.delete(id);
  }

  // ── Monthly filters ─────────────────────────────────────────

  List<IncomeEntry> getIncomesForMonth(int year, int month) {
    return getAllIncomes()
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  List<ExpenseEntry> getExpensesForMonth(int year, int month) {
    return getAllExpenses()
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }

  // ── Monthly reset ────────────────────────────────────────────

  Future<void> clearAll() async {
    await _incomes.clear();
    await _expenses.clear();
  }
}
