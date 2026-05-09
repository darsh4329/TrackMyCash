import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_income_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/daily_summary_screen.dart';
import 'screens/monthly_report_screen.dart';
import 'screens/analytics_screen.dart';

class TrackMyCashApp extends StatelessWidget {
  const TrackMyCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackMyCash',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const SplashScreen(),
        '/dashboard': (ctx) => const DashboardScreen(),
        '/add-income': (ctx) => const AddIncomeScreen(),
        '/add-expense': (ctx) => const AddExpenseScreen(),
        '/daily-summary': (ctx) => const DailySummaryScreen(),
        '/monthly-report': (ctx) => const MonthlyReportScreen(),
        '/analytics': (ctx) => const AnalyticsScreen(),
      },
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.backgroundLight,
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: AppColors.surfaceDark,
        onSurface: Colors.white,
      ),
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
    );
  }
}
