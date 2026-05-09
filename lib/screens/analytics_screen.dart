import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/providers/budget_provider.dart';
import '../widgets/chart_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: const Text('Analytics',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(icon: Icon(Icons.pie_chart_rounded), text: 'Expenses'),
            Tab(icon: Icon(Icons.bar_chart_rounded), text: 'Daily'),
            Tab(icon: Icon(Icons.show_chart_rounded), text: 'Trend'),
          ],
        ),
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, provider, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              _PieChartTab(provider: provider),
              _BarChartTab(provider: provider),
              _LineChartTab(provider: provider),
            ],
          );
        },
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// PIE CHART TAB
// ───────────────────────────────────────────────────────────────────────────
class _PieChartTab extends StatefulWidget {
  final BudgetProvider provider;
  const _PieChartTab({required this.provider});

  @override
  State<_PieChartTab> createState() => _PieChartTabState();
}

class _PieChartTabState extends State<_PieChartTab> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final data = widget.provider.expenseByCategory;
    if (data.isEmpty) return _noDataWidget('No expense data this month');

    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = data.values.fold(0.0, (s, v) => s + v);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ChartCard(
          title: 'Spending by Category',
          subtitle: 'Tap a slice to see details',
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        setState(() {
                          if (response?.touchedSection != null) {
                            _touchedIndex = response!
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            _touchedIndex = null;
                          }
                        });
                      },
                    ),
                    sectionsSpace: 3,
                    centerSpaceRadius: 55,
                    sections: entries.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      final pct = total > 0 ? item.value / total * 100 : 0;
                      final isTouched = _touchedIndex == idx;
                      final color = AppColors
                          .categoryColors[idx % AppColors.categoryColors.length];
                      return PieChartSectionData(
                        value: item.value,
                        color: color,
                        radius: isTouched ? 80 : 70,
                        title: '${pct.toStringAsFixed(1)}%',
                        titleStyle: TextStyle(
                          fontSize: isTouched ? 14 : 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Legend
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: entries.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  final color = AppColors
                      .categoryColors[idx % AppColors.categoryColors.length];
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: color, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${item.key} — ₹${NumberFormat('#,##0', 'en_IN').format(item.value)}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// BAR CHART TAB
// ───────────────────────────────────────────────────────────────────────────
class _BarChartTab extends StatelessWidget {
  final BudgetProvider provider;
  const _BarChartTab({required this.provider});

  @override
  Widget build(BuildContext context) {
    final daily = provider.dailyExpenses;
    if (daily.isEmpty) return _noDataWidget('No daily expense data this month');

    final days = List.generate(31, (i) => i + 1);
    final maxVal =
        daily.values.isEmpty ? 1.0 : daily.values.reduce((a, b) => a > b ? a : b);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ChartCard(
          title: 'Daily Spending',
          subtitle: DateFormat('MMMM yyyy').format(DateTime.now()),
          child: SizedBox(
            height: 260,
            child: BarChart(
              BarChartData(
                maxY: maxVal * 1.2,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: maxVal / 4,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: AppColors.textMuted.withOpacity(0.15),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 44,
                      getTitlesWidget: (v, meta) => Text(
                        '₹${NumberFormat.compact().format(v)}',
                        style: AppTextStyles.bodySmall
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (v, meta) => Text(
                        v.toInt().toString(),
                        style: AppTextStyles.bodySmall
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: days.map((day) {
                  final val = daily[day] ?? 0.0;
                  return BarChartGroupData(
                    x: day,
                    barRods: [
                      BarChartRodData(
                        toY: val,
                        gradient: val > 0
                            ? AppColors.expenseGradient
                            : null,
                        color: val == 0
                            ? AppColors.textMuted.withOpacity(0.15)
                            : null,
                        width: 6,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────
// LINE CHART TAB
// ───────────────────────────────────────────────────────────────────────────
class _LineChartTab extends StatelessWidget {
  final BudgetProvider provider;
  const _LineChartTab({required this.provider});

  @override
  Widget build(BuildContext context) {
    final incomeMap = provider.dailyIncomes;
    final expenseMap = provider.dailyExpenses;
    if (incomeMap.isEmpty && expenseMap.isEmpty) {
      return _noDataWidget('No data available this month');
    }

    final allDays = <int>{...incomeMap.keys, ...expenseMap.keys};
    if (allDays.isEmpty) return _noDataWidget('No data available');

    final sortedDays = allDays.toList()..sort();

    // Profit/Loss per day
    final profitPoints = sortedDays.map((d) {
      final net = (incomeMap[d] ?? 0) - (expenseMap[d] ?? 0);
      return FlSpot(d.toDouble(), net);
    }).toList();

    final allY = profitPoints.map((p) => p.y).toList();
    final minY = allY.isEmpty ? -1000.0 : allY.reduce((a, b) => a < b ? a : b);
    final maxY = allY.isEmpty ? 1000.0 : allY.reduce((a, b) => a > b ? a : b);
    final pad = (maxY - minY).abs() < 100 ? 500.0 : (maxY - minY) * 0.3;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ChartCard(
          title: 'Profit / Loss Trend',
          subtitle: 'Daily net (income minus expense)',
          child: SizedBox(
            height: 260,
            child: LineChart(
              LineChartData(
                minY: minY - pad,
                maxY: maxY + pad,
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: v == 0
                        ? AppColors.textMuted.withOpacity(0.5)
                        : AppColors.textMuted.withOpacity(0.1),
                    strokeWidth: v == 0 ? 1.5 : 1,
                    dashArray: v == 0 ? null : [4, 4],
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (v, meta) => Text(
                        '₹${NumberFormat.compact().format(v)}',
                        style: AppTextStyles.bodySmall
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (v, meta) => Text(
                        v.toInt().toString(),
                        style: AppTextStyles.bodySmall
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: profitPoints,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, _, __, ___) =>
                          FlDotCirclePainter(
                        radius: 4,
                        color: spot.y >= 0
                            ? AppColors.income
                            : AppColors.expense,
                        strokeColor: AppColors.backgroundDark,
                        strokeWidth: 2,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.primary.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Mini legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendDot(AppColors.income, 'Profit day'),
            const SizedBox(width: 20),
            _legendDot(AppColors.expense, 'Loss day'),
          ],
        ),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

Widget _noDataWidget(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.bar_chart_rounded,
            size: 64, color: AppColors.textMuted.withOpacity(0.3)),
        const SizedBox(height: 16),
        Text(message,
            style: AppTextStyles.titleMedium
                .copyWith(color: AppColors.textMuted)),
        const SizedBox(height: 8),
        const Text(
          'Add some entries to see analytics',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
      ],
    ),
  );
}
