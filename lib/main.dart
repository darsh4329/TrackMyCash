import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/models/income_entry.dart';
import 'core/models/expense_entry.dart';
import 'core/providers/budget_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(IncomeEntryAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ExpenseEntryAdapter());
  }


  // Open boxes
  await Hive.openBox<IncomeEntry>('incomes');
  await Hive.openBox<ExpenseEntry>('expenses');

  runApp(
    ChangeNotifierProvider(
      create: (_) => BudgetProvider()..loadFromStorage(),
      child: const TrackMyCashApp(),
    ),
  );
}
