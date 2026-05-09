import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/providers/budget_provider.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedSource = 'Salary';
  final List<String> _sources = ['Salary', 'Freelance', 'Business', 'Investment', 'Other'];

  final Map<String, IconData> _sourceIcons = {
    'Salary': Icons.work_rounded,
    'Freelance': Icons.laptop_rounded,
    'Business': Icons.store_rounded,
    'Investment': Icons.trending_up_rounded,
    'Other': Icons.more_horiz_rounded,
  };

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    context.read<BudgetProvider>().addTempIncome(
          amount: amount,
          source: _selectedSource,
          description: _descController.text.trim(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Income added to today\'s list!'),
          ],
        ),
        backgroundColor: AppColors.income,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
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
        title: const Text('Add Income',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.incomeGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.income.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_downward_rounded,
                        color: Colors.white, size: 32),
                    const SizedBox(height: 8),
                    const Text('Income Entry',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    Text(
                      _getFormattedToday(),
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Amount field
              Text('Amount', style: AppTextStyles.titleMedium),
              const SizedBox(height: 8),
              _buildAmountField(),

              const SizedBox(height: 20),

              // Source picker
              Text('Income Source', style: AppTextStyles.titleMedium),
              const SizedBox(height: 12),
              _buildSourcePicker(),

              const SizedBox(height: 20),

              // Description field
              Text('Description', style: AppTextStyles.titleMedium),
              const SizedBox(height: 8),
              _buildDescField(),

              const SizedBox(height: 36),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.income,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: AppColors.income.withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_rounded),
                      SizedBox(width: 8),
                      Text('Add to Today',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
      validator: (val) {
        if (val == null || val.isEmpty) return 'Enter an amount';
        if (double.tryParse(val) == null) return 'Enter a valid number';
        if (double.parse(val) <= 0) return 'Amount must be greater than 0';
        return null;
      },
      decoration: InputDecoration(
        prefixText: '₹  ',
        prefixStyle: const TextStyle(
            color: AppColors.income, fontSize: 20, fontWeight: FontWeight.w700),
        hintText: '0.00',
        hintStyle: TextStyle(color: AppColors.textMuted.withOpacity(0.5),
            fontSize: 24),
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.income, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.expense, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }

  Widget _buildSourcePicker() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _sources.map((source) {
        final isSelected = _selectedSource == source;
        return GestureDetector(
          onTap: () => setState(() => _selectedSource = source),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.incomeGradient : null,
              color: isSelected ? null : AppColors.cardDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColors.textMuted.withOpacity(0.2),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.income.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _sourceIcons[source]!,
                  size: 16,
                  color: isSelected ? Colors.white : AppColors.textMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  source,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textMuted,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDescField() {
    return TextFormField(
      controller: _descController,
      style: const TextStyle(color: Colors.white),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Optional note about this income...',
        hintStyle: TextStyle(color: AppColors.textMuted.withOpacity(0.5)),
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.income, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  String _getFormattedToday() {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}
