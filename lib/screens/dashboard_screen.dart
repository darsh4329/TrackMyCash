import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/providers/budget_provider.dart';
import '../widgets/summary_card.dart';
import '../widgets/entry_list_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_IN');
    return '₹${formatter.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Consumer<BudgetProvider>(
        builder: (context, provider, _) {
          final balance = provider.monthlyBalance;
          final isProfit = balance >= 0;

          return CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: AppColors.backgroundDark,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeader(context, provider, balance, isProfit),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.bar_chart_rounded,
                        color: Colors.white),
                    tooltip: 'Analytics',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/analytics'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.summarize_rounded,
                        color: Colors.white),
                    tooltip: 'Monthly Report',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/monthly-report'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // ── Summary Cards ─────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          label: 'Income',
                          amount: _formatCurrency(provider.totalMonthlyIncome),
                          icon: Icons.arrow_downward_rounded,
                          gradient: AppColors.incomeGradient,
                          subtitle: 'This month',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          label: 'Expenses',
                          amount: _formatCurrency(provider.totalMonthlyExpense),
                          icon: Icons.arrow_upward_rounded,
                          gradient: AppColors.expenseGradient,
                          subtitle: 'This month',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Today's Entries Header ─────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Today's Entries",
                          style: AppTextStyles.headlineMedium),
                      TextButton.icon(
                        icon: const Icon(Icons.list_alt_rounded, size: 18),
                        label: const Text('Daily Summary'),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/daily-summary'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Temp income entries ───────────────────────────
              if (provider.tempIncomes.isEmpty && provider.tempExpenses.isEmpty)
                SliverToBoxAdapter(
                  child: _buildEmptyState(),
                )
              else ...[
                if (provider.tempIncomes.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                        final e = provider.tempIncomes[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: EntryListTile(
                            title: e.source,
                            subtitle: e.description,
                            amount: e.amount,
                            date: e.formattedDate,
                            isIncome: true,
                            onDelete: () => provider.removeTempIncome(e.id),
                          ),
                        );
                      },
                      childCount: provider.tempIncomes.length,
                    ),
                  ),
                if (provider.tempExpenses.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                        final e = provider.tempExpenses[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: EntryListTile(
                            title: e.category,
                            subtitle: e.description,
                            amount: e.amount,
                            date: e.formattedDate,
                            isIncome: false,
                            onDelete: () => provider.removeTempExpense(e.id),
                          ),
                        );
                      },
                      childCount: provider.tempExpenses.length,
                    ),
                  ),
              ],

              // Bottom padding for FABs
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),

      // ── FAB Group ─────────────────────────────────────────
      floatingActionButton: _buildFabGroup(context),
    );
  }

  Widget _buildHeader(BuildContext context, BudgetProvider provider,
      double balance, bool isProfit) {
    final now = DateTime.now();
    final monthName = DateFormat('MMMM yyyy').format(now);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF0F0F1A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text('TrackMyCash',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Text(monthName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textMuted,
              )),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => (isProfit
                          ? AppColors.incomeGradient
                          : AppColors.expenseGradient)
                      .createShader(bounds),
                  child: Text(
                    NumberFormat('#,##0.00', 'en_IN')
                        .format(balance.abs())
                        .padLeft(1, '₹'),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isProfit
                        ? AppColors.income.withOpacity(0.2)
                        : AppColors.expense.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isProfit ? '▲ PROFIT' : '▼ LOSS',
                    style: TextStyle(
                      color: isProfit ? AppColors.income : AppColors.expense,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Remaining Balance',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
      child: Column(
        children: [
          Icon(Icons.inbox_rounded,
              size: 64, color: AppColors.textMuted.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text(
            "No entries yet today",
            style: AppTextStyles.titleMedium
                .copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the + buttons below to add\nyour income or expenses",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFabGroup(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: 'fab_income',
          onPressed: () => Navigator.pushNamed(context, '/add-income'),
          backgroundColor: AppColors.income,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Income',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          heroTag: 'fab_expense',
          onPressed: () => Navigator.pushNamed(context, '/add-expense'),
          backgroundColor: AppColors.expense,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.remove_rounded),
          label: const Text('Expense',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
