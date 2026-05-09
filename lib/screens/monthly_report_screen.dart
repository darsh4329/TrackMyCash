import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/providers/budget_provider.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  String _fmt(double v) =>
      '₹${NumberFormat('#,##0.00', 'en_IN').format(v)}';

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
        title: Text(
          'Monthly Report — ${DateFormat('MMMM yyyy').format(DateTime.now())}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/analytics'),
          ),
        ],
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, provider, _) {
          final balance = provider.monthlyBalance;
          final isProfit = balance >= 0;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Hero balance card ─────────────────────────────
              _buildHeroCard(provider, balance, isProfit),

              const SizedBox(height: 20),

              // ── Stats grid ───────────────────────────────────
              Text('Overview', style: AppTextStyles.headlineMedium),
              const SizedBox(height: 12),
              _buildStatsGrid(provider, isProfit),

              const SizedBox(height: 20),

              // ── Insights ─────────────────────────────────────
              Text('Insights', style: AppTextStyles.headlineMedium),
              const SizedBox(height: 12),
              _buildInsightTile(
                icon: Icons.shopping_cart_rounded,
                color: AppColors.expense,
                label: 'Most Spent Category',
                value: provider.mostSpentCategory,
              ),
              const SizedBox(height: 10),
              _buildInsightTile(
                icon: Icons.trending_up_rounded,
                color: AppColors.income,
                label: 'Most Earned Source',
                value: provider.mostEarnedSource,
              ),
              const SizedBox(height: 10),
              _buildInsightTile(
                icon: Icons.calendar_today_rounded,
                color: AppColors.balance,
                label: 'Avg Daily Spending',
                value: _fmt(provider.averageDailySpending),
              ),

              const SizedBox(height: 20),

              // ── Expense Breakdown ─────────────────────────────
              if (provider.expenseByCategory.isNotEmpty) ...[
                Text('Expense Breakdown',
                    style: AppTextStyles.headlineMedium),
                const SizedBox(height: 12),
                _buildCategoryBreakdown(provider),
              ],

              const SizedBox(height: 20),

              // ── Reset button ──────────────────────────────────
              OutlinedButton.icon(
                onPressed: () => _confirmReset(context, provider),
                icon: const Icon(Icons.refresh_rounded,
                    color: AppColors.expense),
                label: const Text('Reset Month',
                    style: TextStyle(color: AppColors.expense)),
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color: AppColors.expense, width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(
      BudgetProvider provider, double balance, bool isProfit) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E35), Color(0xFF252540)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isProfit ? AppColors.income : AppColors.expense)
              .withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: (isProfit ? AppColors.income : AppColors.expense)
                .withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isProfit ? AppColors.income : AppColors.expense)
                      .withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isProfit
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: isProfit ? AppColors.income : AppColors.expense,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isProfit ? 'Net Profit' : 'Net Loss',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${NumberFormat('#,##0.00', 'en_IN').format(balance.abs())}',
                    style: TextStyle(
                      color:
                          isProfit ? AppColors.income : AppColors.expense,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _balancePill('Total Income',
                  '₹${NumberFormat('#,##0.00', 'en_IN').format(provider.totalMonthlyIncome)}',
                  AppColors.income),
              const SizedBox(width: 12),
              _balancePill('Total Expense',
                  '₹${NumberFormat('#,##0.00', 'en_IN').format(provider.totalMonthlyExpense)}',
                  AppColors.expense),
            ],
          ),
        ],
      ),
    );
  }

  Widget _balancePill(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: color.withOpacity(0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    color: color, fontSize: 15, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BudgetProvider provider, bool isProfit) {
    final items = [
      _StatItem('Entries', '${provider.monthlyIncomes.length + provider.monthlyExpenses.length}',
          Icons.receipt_long_rounded, AppColors.primary),
      _StatItem('Income Entries', '${provider.monthlyIncomes.length}',
          Icons.arrow_downward_rounded, AppColors.income),
      _StatItem('Expense Entries', '${provider.monthlyExpenses.length}',
          Icons.arrow_upward_rounded, AppColors.expense),
      _StatItem(
        isProfit ? 'Profit' : 'Loss',
        '₹${NumberFormat('#,##0', 'en_IN').format(provider.monthlyBalance.abs())}',
        isProfit ? Icons.thumb_up_rounded : Icons.thumb_down_rounded,
        isProfit ? AppColors.income : AppColors.expense,
      ),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: item.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: item.color.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Icon(item.icon, color: item.color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.label,
                        style: TextStyle(
                            color: item.color.withOpacity(0.8),
                            fontSize: 11)),
                    const SizedBox(height: 4),
                    FittedBox(
                      child: Text(item.value,
                          style: TextStyle(
                              color: item.color,
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInsightTile({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodySmall),
                const SizedBox(height: 3),
                Text(value, style: AppTextStyles.titleLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(BudgetProvider provider) {
    final total = provider.totalMonthlyExpense;
    final categories = provider.expenseByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: categories.asMap().entries.map((entry) {
          final idx = entry.key;
          final cat = entry.value;
          final pct = total > 0 ? cat.value / total : 0.0;
          final color = AppColors.categoryColors[
              idx % AppColors.categoryColors.length];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Text(cat.key,
                            style: AppTextStyles.titleMedium),
                      ],
                    ),
                    Text(
                      '₹${NumberFormat('#,##0', 'en_IN').format(cat.value)} (${(pct * 100).toStringAsFixed(1)}%)',
                      style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: pct,
                    backgroundColor: color.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _confirmReset(
      BuildContext context, BudgetProvider provider) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Month?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text(
          'This will permanently delete ALL data for this month. This cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:
                const Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expense,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await provider.resetMonth();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  _StatItem(this.label, this.value, this.icon, this.color);
}
