import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/providers/budget_provider.dart';
import '../widgets/entry_list_tile.dart';

class DailySummaryScreen extends StatelessWidget {
  const DailySummaryScreen({super.key});

  String _format(double v) {
    return '₹${NumberFormat('#,##0.00', 'en_IN').format(v)}';
  }

  Future<void> _confirmSubmit(BuildContext context) async {
    final provider = context.read<BudgetProvider>();
    if (provider.tempIncomes.isEmpty && provider.tempExpenses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No entries to submit!'),
          backgroundColor: AppColors.textMuted,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Submit Day?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text(
          'This will save all today\'s entries permanently.\nYou cannot undo this action.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Submit',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await provider.submitDay();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.cloud_done_rounded, color: Colors.white),
                SizedBox(width: 8),
                Text('Day submitted successfully!'),
              ],
            ),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Today's Summary",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20)),
        centerTitle: true,
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, provider, _) {
          final netDay =
              provider.tempTotalIncome - provider.tempTotalExpense;
          final isProfit = netDay >= 0;

          return Column(
            children: [
              // ── Totals row ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    _buildMiniCard(
                      'Income',
                      _format(provider.tempTotalIncome),
                      AppColors.income,
                      Icons.arrow_downward_rounded,
                    ),
                    const SizedBox(width: 12),
                    _buildMiniCard(
                      'Expense',
                      _format(provider.tempTotalExpense),
                      AppColors.expense,
                      Icons.arrow_upward_rounded,
                    ),
                    const SizedBox(width: 12),
                    _buildMiniCard(
                      isProfit ? 'Profit' : 'Loss',
                      _format(netDay.abs()),
                      isProfit ? AppColors.income : AppColors.expense,
                      isProfit
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Entries list ────────────────────────────────
              Expanded(
                child: (provider.tempIncomes.isEmpty &&
                        provider.tempExpenses.isEmpty)
                    ? _buildEmptyState()
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          if (provider.tempIncomes.isNotEmpty) ...[
                            _sectionHeader('Income Entries',
                                AppColors.income),
                            ...provider.tempIncomes.map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8),
                                child: EntryListTile(
                                  title: e.source,
                                  subtitle: e.description,
                                  amount: e.amount,
                                  date: e.formattedDate,
                                  isIncome: true,
                                  onDelete: () =>
                                      provider.removeTempIncome(e.id),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if (provider.tempExpenses.isNotEmpty) ...[
                            _sectionHeader('Expense Entries',
                                AppColors.expense),
                            ...provider.tempExpenses.map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8),
                                child: EntryListTile(
                                  title: e.category,
                                  subtitle: e.description,
                                  amount: e.amount,
                                  date: e.formattedDate,
                                  isIncome: false,
                                  onDelete: () =>
                                      provider.removeTempExpense(e.id),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 80),
                        ],
                      ),
              ),
            ],
          );
        },
      ),

      // ── Submit Day Button ───────────────────────────────────
      floatingActionButton: Consumer<BudgetProvider>(
        builder: (ctx, provider, _) {
          final hasEntries =
              provider.tempIncomes.isNotEmpty || provider.tempExpenses.isNotEmpty;
          return FloatingActionButton.extended(
            onPressed:
                hasEntries ? () => _confirmSubmit(context) : null,
            backgroundColor:
                hasEntries ? AppColors.primary : AppColors.textMuted,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.cloud_upload_rounded),
            label: const Text('Submit Day',
                style: TextStyle(fontWeight: FontWeight.w700)),
          );
        },
      ),
    );
  }

  Widget _buildMiniCard(
      String label, String amount, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    color: color, fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(amount,
                  style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          Container(
              width: 4, height: 18,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                  color: color, fontSize: 14, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.today_rounded,
              size: 64, color: AppColors.textMuted.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text('No entries for today',
              style: AppTextStyles.titleMedium
                  .copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 8),
          Text('Add income or expenses from the dashboard',
              style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
