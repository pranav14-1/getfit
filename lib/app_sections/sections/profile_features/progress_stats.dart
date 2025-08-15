import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

class ProgressStatsScreen extends StatefulWidget {
  const ProgressStatsScreen({super.key});

  @override
  State<ProgressStatsScreen> createState() => _ProgressStatsScreenState();
}

class _ProgressStatsScreenState extends State<ProgressStatsScreen> {
  String _selectedTimeframe = 'This Month';

  // Responsive breakpoints (same as profile screen)
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;
  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  EdgeInsets _getResponsivePadding(BuildContext context) {
    if (_isDesktop(context)) return const EdgeInsets.all(32.0);
    if (_isTablet(context)) return const EdgeInsets.all(24.0);
    return const EdgeInsets.all(16.0);
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (_isDesktop(context)) return baseSize + 4;
    if (_isTablet(context)) return baseSize + 2;
    return baseSize;
  }

  // Section header widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: _isMobile(context) ? 4 : 8,
        bottom: _isMobile(context) ? 12 : 16,
        top: _isMobile(context) ? 16 : 20,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _getResponsiveFontSize(context, 18),
          color: AppColors.font1,
        ),
      ),
    );
  }

  // Stats card (enhanced version from profile screen)
  Widget _buildStatsCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    String? trend,
    bool showTrend = false,
  }) {
    return Container(
      padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (showTrend && trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trend,
                    style: TextStyle(
                      color: Colors.green.shade600,
                      fontSize: _getResponsiveFontSize(context, 10),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _getResponsiveFontSize(context, 24),
              color: AppColors.font1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: AppColors.font1,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 12),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Progress indicator widget
  Widget _buildProgressIndicator({
    required String title,
    required String current,
    required String target,
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: _getResponsiveFontSize(context, 16),
                        color: AppColors.font1,
                      ),
                    ),
                    Text(
                      '$current / $target',
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 16),
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  // Achievement widget
  Widget _buildAchievement({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    bool isCompleted = true,
  }) {
    return Container(
      padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: isCompleted
            ? Border.all(color: color.withOpacity(0.3), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isCompleted ? Colors.white : Colors.grey.shade600,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: _getResponsiveFontSize(context, 16),
                    color: isCompleted
                        ? AppColors.font1
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 12),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted) Icon(Icons.check_circle, color: color, size: 20),
        ],
      ),
    );
  }

  // Timeframe selector
  Widget _buildTimeframeSelector() {
    final timeframes = [
      'This Week',
      'This Month',
      'Last 3 Months',
      'This Year',
    ];

    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeframes.length,
        itemBuilder: (context, index) {
          final timeframe = timeframes[index];
          final isSelected = _selectedTimeframe == timeframe;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                timeframe,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.font1,
                  fontSize: _getResponsiveFontSize(context, 12),
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  _selectedTimeframe = timeframe;
                });
              },
              backgroundColor: Theme.of(context).cardTheme.color,
              selectedColor: AppColors.buttons,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? AppColors.buttons : AppColors.dividerColor,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Progress & Stats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _getResponsiveFontSize(context, 24),
            color: AppColors.font1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.font1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(_isMobile(context) ? 20 : 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade600, Colors.purple.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.bar_chart,
                      color: Colors.white,
                      size: _isMobile(context) ? 40 : 50,
                    ),
                    SizedBox(height: _isMobile(context) ? 12 : 16),
                    Text(
                      'Your Progress Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _getResponsiveFontSize(context, 20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Track your fitness achievements',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                  ],
                ),
              ),

              _buildSectionHeader('Timeframe'),
              _buildTimeframeSelector(),

              _buildSectionHeader('Overview'),

              // Stats Grid
              GridView.count(
                crossAxisCount: _isMobile(context) ? 2 : 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: _isMobile(context) ? 1.0 : 1.2,
                children: [
                  _buildStatsCard(
                    title: 'Total Workouts',
                    value: '127',
                    subtitle: 'This month',
                    icon: Icons.fitness_center,
                    color: Colors.orange.shade600,
                    trend: '+12%',
                    showTrend: true,
                  ),
                  _buildStatsCard(
                    title: 'Calories Burned',
                    value: '8,450',
                    subtitle: 'This month',
                    icon: Icons.local_fire_department,
                    color: Colors.red.shade600,
                    trend: '+8%',
                    showTrend: true,
                  ),
                  _buildStatsCard(
                    title: 'Active Minutes',
                    value: '2,340',
                    subtitle: 'This month',
                    icon: Icons.timer,
                    color: Colors.blue.shade600,
                    trend: '+15%',
                    showTrend: true,
                  ),
                  _buildStatsCard(
                    title: 'Current Streak',
                    value: '15',
                    subtitle: 'Days',
                    icon: Icons.whatshot,
                    color: Colors.green.shade600,
                    trend: 'Active',
                    showTrend: true,
                  ),
                ],
              ),

              _buildSectionHeader('Goals Progress'),

              // Progress Indicators
              _buildProgressIndicator(
                title: 'Weekly Workout Goal',
                current: '4',
                target: '5',
                progress: 0.8,
                color: Colors.blue.shade600,
                icon: Icons.fitness_center,
              ),

              const SizedBox(height: 12),

              _buildProgressIndicator(
                title: 'Monthly Calorie Goal',
                current: '8,450',
                target: '10,000',
                progress: 0.845,
                color: Colors.red.shade600,
                icon: Icons.local_fire_department,
              ),

              const SizedBox(height: 12),

              _buildProgressIndicator(
                title: 'Weight Loss Goal',
                current: '3.2',
                target: '5.0',
                progress: 0.64,
                color: Colors.green.shade600,
                icon: Icons.monitor_weight,
              ),

              _buildSectionHeader('Recent Achievements'),

              // Achievements
              Column(
                children: [
                  _buildAchievement(
                    title: 'First Week Complete',
                    description: 'Completed your first week of workouts',
                    icon: Icons.star,
                    color: Colors.amber.shade600,
                  ),
                  const SizedBox(height: 12),
                  _buildAchievement(
                    title: '100 Workouts',
                    description: 'Reached 100 total workouts milestone',
                    icon: Icons.military_tech,
                    color: Colors.orange.shade600,
                  ),
                  const SizedBox(height: 12),
                  _buildAchievement(
                    title: '2 Week Streak',
                    description: 'Maintained a 14-day workout streak',
                    icon: Icons.local_fire_department,
                    color: Colors.red.shade600,
                  ),
                  const SizedBox(height: 12),
                  _buildAchievement(
                    title: '5000 Calories',
                    description: 'Burn 5000 calories in a month',
                    icon: Icons.trending_up,
                    color: Colors.grey.shade400,
                    isCompleted: false,
                  ),
                ],
              ),

              SizedBox(height: _isMobile(context) ? 16 : 20),
            ],
          ),
        ),
      ),
    );
  }
}
