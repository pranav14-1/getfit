import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Nutritionscreen extends StatefulWidget {
  const Nutritionscreen({super.key});

  @override
  State<Nutritionscreen> createState() => _NutritionscreenState();
}

class _NutritionscreenState extends State<Nutritionscreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  // Form controllers
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _foodQuantityController = TextEditingController();
  final TextEditingController _drinkController = TextEditingController();
  final TextEditingController _drinkQuantityController =
      TextEditingController();

  // Sample data for macros
  final Map<String, double> macroData = {
    'protein': 0.65, // 65% of daily goal
    'carbs': 0.43, // 43% of daily goal
    'fats': 0.28, // 28% of daily goal
  };

  // Updated diet history with explicit types and null safety
  final List<Map<String, dynamic>> dietHistory = [
    <String, dynamic>{
      'date': 'Today',
      'fullDate': 'Dec 15, 2024',
      'totalCalories': 890,
      'mealsCount': 3,
      'targetCalories': 2200,
      'progress': 0.40,
      'status': 'On Track',
    },
    <String, dynamic>{
      'date': 'Yesterday',
      'fullDate': 'Dec 14, 2024',
      'totalCalories': 2150,
      'mealsCount': 4,
      'targetCalories': 2200,
      'progress': 0.98,
      'status': 'Excellent',
    },
    <String, dynamic>{
      'date': 'Dec 13',
      'fullDate': 'Dec 13, 2024',
      'totalCalories': 1850,
      'mealsCount': 3,
      'targetCalories': 2200,
      'progress': 0.84,
      'status': 'Good',
    },
    <String, dynamic>{
      'date': 'Dec 12',
      'fullDate': 'Dec 12, 2024',
      'totalCalories': 2350,
      'mealsCount': 5,
      'targetCalories': 2200,
      'progress': 1.07,
      'status': 'Over Target',
    },
    <String, dynamic>{
      'date': 'Dec 11',
      'fullDate': 'Dec 11, 2024',
      'totalCalories': 1950,
      'mealsCount': 4,
      'targetCalories': 2200,
      'progress': 0.89,
      'status': 'Good',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _foodController.dispose();
    _foodQuantityController.dispose();
    _drinkController.dispose();
    _drinkQuantityController.dispose();
    super.dispose();
  }

  // Responsive breakpoints
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;
  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  // Responsive padding
  EdgeInsets _getResponsivePadding(BuildContext context) {
    if (_isDesktop(context)) return const EdgeInsets.all(32.0);
    if (_isTablet(context)) return const EdgeInsets.all(24.0);
    return const EdgeInsets.all(16.0);
  }

  // Responsive font size
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (_isDesktop(context)) return baseSize + 4;
    if (_isTablet(context)) return baseSize + 2;
    return baseSize;
  }

  // Build macro progress indicator with theme support
  Widget _buildMacroIndicator({
    required BuildContext context,
    required String title,
    required double percent,
    required Color color,
    required String current,
    required String target,
  }) {
    final radius = _isMobile(context)
        ? 35.0
        : _isTablet(context)
        ? 40.0
        : 45.0;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(_isMobile(context) ? 12 : 16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: radius,
              lineWidth: _isMobile(context) ? 6 : 8,
              percent: percent,
              progressColor: color,
              backgroundColor: color.withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '${(percent * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _isMobile(context) ? 12 : 14,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: _isMobile(context) ? 8 : 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _isMobile(context) ? 12 : 14,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '$current/$target',
              style: TextStyle(
                fontSize: _isMobile(context) ? 10 : 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build responsive text field with theme support
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: AppColors.font1),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.buttons, width: 2),
          ),
          labelStyle: TextStyle(color: AppColors.textSecondary),
          hintStyle: TextStyle(color: AppColors.textSecondary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Build diet history item with theme support
  Widget _buildDietHistoryItem(Map<String, dynamic> item) {
    // Get status color with null safety
    Color getStatusColor(String? status, double? progress) {
      if (status == null || progress == null) return Colors.grey;

      if (status == 'Excellent' || (progress >= 0.95 && progress <= 1.05)) {
        return Colors.green;
      } else if (status == 'Over Target' || progress > 1.05) {
        return Colors.red;
      } else if (status == 'Good' || progress >= 0.80) {
        return Colors.orange;
      } else {
        return Colors.grey;
      }
    }

    // Safe access to map values with null checks
    final String date = item['date'] ?? 'Unknown Date';
    final String fullDate = item['fullDate'] ?? '';
    final int totalCalories = item['totalCalories'] ?? 0;
    final int mealsCount = item['mealsCount'] ?? 0;
    final int targetCalories = item['targetCalories'] ?? 2200;
    final double progress = (item['progress'] ?? 0.0).toDouble();
    final String status = item['status'] ?? 'Unknown';

    final statusColor = getStatusColor(status, progress);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(_isMobile(context) ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: _isMobile(context) ? 16 : 18,
                      color: AppColors.font1,
                    ),
                  ),
                  if (fullDate.isNotEmpty)
                    Text(
                      fullDate,
                      style: TextStyle(
                        fontSize: _isMobile(context) ? 12 : 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: _isMobile(context) ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 16,
                        color: Colors.orange.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$totalCalories cal',
                        style: TextStyle(
                          fontSize: _isMobile(context) ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.font1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$mealsCount meals',
                    style: TextStyle(
                      fontSize: _isMobile(context) ? 12 : 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress > 1.0 ? 1.0 : progress,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700
                    : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toInt()}% of target',
                    style: TextStyle(
                      fontSize: _isMobile(context) ? 10 : 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Target: $targetCalories cal',
                    style: TextStyle(
                      fontSize: _isMobile(context) ? 10 : 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Track Nutrition',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _getResponsiveFontSize(context, 20),
            color: AppColors.font1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Overview Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today\'s Intake',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _getResponsiveFontSize(context, 18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Keep up the great work!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: _getResponsiveFontSize(context, 12),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: _isMobile(context) ? 20 : 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '890',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _getResponsiveFontSize(context, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Calories consumed',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: _getResponsiveFontSize(context, 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '1,310',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _getResponsiveFontSize(context, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Remaining',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: _getResponsiveFontSize(context, 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // Daily Macros Section
              Text(
                'Daily Macros',
                style: TextStyle(
                  color: AppColors.font1,
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: _isMobile(context) ? 12 : 16),

              Row(
                children: [
                  _buildMacroIndicator(
                    context: context,
                    title: 'Protein',
                    percent: macroData['protein']!,
                    color: Colors.blue.shade600,
                    current: '98g',
                    target: '150g',
                  ),
                  const SizedBox(width: 12),
                  _buildMacroIndicator(
                    context: context,
                    title: 'Carbs',
                    percent: macroData['carbs']!,
                    color: Colors.orange.shade600,
                    current: '86g',
                    target: '200g',
                  ),
                  const SizedBox(width: 12),
                  _buildMacroIndicator(
                    context: context,
                    title: 'Fats',
                    percent: macroData['fats']!,
                    color: Colors.purple.shade600,
                    current: '28g',
                    target: '100g',
                  ),
                ],
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // Log Intake Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: AppColors.buttons,
                          size: _isMobile(context) ? 20 : 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Log Intake',
                          style: TextStyle(
                            color: AppColors.font1,
                            fontWeight: FontWeight.bold,
                            fontSize: _getResponsiveFontSize(context, 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: _isMobile(context) ? 16 : 20),

                    // Whole Foods Section
                    Text(
                      'Whole Foods',
                      style: TextStyle(
                        color: AppColors.font1,
                        fontWeight: FontWeight.w600,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _foodController,
                      labelText: 'Food item',
                      hintText: 'e.g., Grilled chicken breast',
                    ),
                    _buildTextField(
                      controller: _foodQuantityController,
                      labelText: 'Quantity (grams)',
                      hintText: 'e.g., 150',
                      keyboardType: TextInputType.number,
                    ),

                    // Beverages Section
                    Text(
                      'Beverages',
                      style: TextStyle(
                        color: AppColors.font1,
                        fontWeight: FontWeight.w600,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _drinkController,
                      labelText: 'Beverage',
                      hintText: 'e.g., Green smoothie',
                    ),
                    _buildTextField(
                      controller: _drinkQuantityController,
                      labelText: 'Quantity (ml)',
                      hintText: 'e.g., 250',
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add your logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Intake logged successfully!',
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttons,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: _isMobile(context) ? 14 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.add, size: 20),
                        label: Text(
                          'Add Calories Intake',
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // Diet History Section
              Text(
                'Diet History',
                style: TextStyle(
                  color: AppColors.font1,
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: _isMobile(context) ? 12 : 16),

              // History items with daily totals
              ...dietHistory
                  .map((item) => _buildDietHistoryItem(item))
                  .toList(),

              // View all button
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // Navigate to full history
                  },
                  icon: Icon(
                    Icons.history,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  label: Text(
                    'View Full History',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: _getResponsiveFontSize(context, 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
