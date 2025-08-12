import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

class Workoutscreen extends StatefulWidget {
  const Workoutscreen({super.key});

  @override
  State<Workoutscreen> createState() => _WorkoutscreenState();
}

class _WorkoutscreenState extends State<Workoutscreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;

  final List<Map<String, dynamic>> workoutRoutines = [
    {
      'name': 'Push Day',
      'exercises': 6,
      'duration': '45 min',
      'lastPerformed': '2 days ago',
      'icon': Icons.fitness_center,
      'color': Colors.orange.shade600,
      'muscleGroups': ['Chest', 'Shoulders', 'Triceps'],
    },
    {
      'name': 'Pull Day',
      'exercises': 5,
      'duration': '40 min',
      'lastPerformed': '4 days ago',
      'icon': Icons.sports_gymnastics,
      'color': Colors.blue.shade600,
      'muscleGroups': ['Back', 'Biceps', 'Lats'],
    },
    {
      'name': 'Leg Day',
      'exercises': 7,
      'duration': '50 min',
      'lastPerformed': '1 week ago',
      'icon': Icons.directions_run,
      'color': Colors.green.shade600,
      'muscleGroups': ['Quads', 'Hamstrings', 'Glutes'],
    },
  ];

  // Sample workout history
  final List<Map<String, dynamic>> workoutHistory = [
    {
      'date': 'Today',
      'workout': 'Upper Body Strength',
      'duration': '42 min',
      'exercises': 8,
      'caloriesBurned': 320,
      'status': 'Completed',
      'intensity': 'High',
    },
    {
      'date': 'Yesterday',
      'workout': 'HIIT Cardio',
      'duration': '25 min',
      'exercises': 6,
      'caloriesBurned': 280,
      'status': 'Completed',
      'intensity': 'Medium',
    },
    {
      'date': '2 days ago',
      'workout': 'Push Day',
      'duration': '45 min',
      'exercises': 6,
      'caloriesBurned': 350,
      'status': 'Completed',
      'intensity': 'High',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  // Responsive breakpoints
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;
  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  bool _isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 350;

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

  // Welcome card matching home theme with theme support
  Widget _buildWelcomeCard() {
    return Container(
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ready to Workout?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Let\'s build those muscles!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: _getResponsiveFontSize(context, 12),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _floatingController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 2 * _floatingController.value),
                    child: Container(
                      padding: EdgeInsets.all(_isMobile(context) ? 6 : 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.sports_gymnastics,
                        color: Colors.white,
                        size: _isMobile(context) ? 20 : 24,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _getResponsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'This week',
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '127',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _getResponsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Total workouts',
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
    );
  }

  // Routine card with theme support
  Widget _buildRoutineCard(Map<String, dynamic> routine) {
    final String name = routine['name'] ?? 'Unknown Workout';
    final int exercises = routine['exercises'] ?? 0;
    final String duration = routine['duration'] ?? '0 min';
    final String lastPerformed = routine['lastPerformed'] ?? 'Never';
    final IconData icon = routine['icon'] ?? Icons.fitness_center;
    final Color color = routine['color'] ?? Colors.orange.shade600;
    final List<String> muscleGroups = List<String>.from(
      routine['muscleGroups'] ?? [],
    );

    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Starting $name workout...'),
                backgroundColor: color,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _getResponsiveFontSize(context, 18),
                              color: AppColors.font1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$exercises exercises • $duration',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 14),
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Muscle groups
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: muscleGroups
                      .map(
                        (group) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade700
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            group,
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 12),
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 12),

                Text(
                  'Last performed: $lastPerformed',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 12),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // History item with theme support
  Widget _buildHistoryItem(Map<String, dynamic> item) {
    final String date = item['date'] ?? 'Unknown Date';
    final String workout = item['workout'] ?? 'Unknown Workout';
    final String duration = item['duration'] ?? '0 min';
    final int exercises = item['exercises'] ?? 0;
    final int caloriesBurned = item['caloriesBurned'] ?? 0;
    final String status = item['status'] ?? 'Unknown';

    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 12 : 16),
      padding: EdgeInsets.all(_isMobile(context) ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: _getResponsiveFontSize(context, 14),
                        color: AppColors.font1,
                      ),
                    ),
                    Text(
                      workout,
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 12),
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: _getResponsiveFontSize(context, 10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _buildStatChip(Icons.timer, duration, Colors.blue.shade600),
              const SizedBox(width: 12),
              _buildStatChip(
                Icons.fitness_center,
                '$exercises ex',
                Colors.orange.shade600,
              ),
              const SizedBox(width: 12),
              _buildStatChip(
                Icons.local_fire_department,
                '$caloriesBurned cal',
                Colors.red.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Stat chip matching home theme
  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 11),
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
          'Track Workout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _getResponsiveFontSize(context, 26),
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
              // Welcome card
              _buildWelcomeCard(),

              SizedBox(height: _isMobile(context) ? 16 : 24),

              // Quick Start Section
              Text(
                'Quick Start',
                style: TextStyle(
                  color: AppColors.font1,
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: _isMobile(context) ? 12 : 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Starting empty workout...'),
                        backgroundColor: AppColors.buttons,
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
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    'Start Empty Workout',
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: _isMobile(context) ? 16 : 24),

              // Routines Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Routines',
                    style: TextStyle(
                      color: AppColors.font1,
                      fontWeight: FontWeight.bold,
                      fontSize: _getResponsiveFontSize(context, 18),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.note_add,
                      size: 16,
                      color: AppColors.buttons,
                    ),
                    label: Text(
                      'New',
                      style: TextStyle(
                        color: AppColors.buttons,
                        fontSize: _getResponsiveFontSize(context, 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _isMobile(context) ? 12 : 16),

              // Routine cards
              ...workoutRoutines.map((routine) => _buildRoutineCard(routine)),

              SizedBox(height: _isMobile(context) ? 16 : 24),

              // Recent Workouts Section
              Text(
                'Recent Workouts',
                style: TextStyle(
                  color: AppColors.font1,
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: _isMobile(context) ? 12 : 16),

              // History items
              ...workoutHistory.map((item) => _buildHistoryItem(item)),

              // View all button
              Center(
                child: TextButton.icon(
                  onPressed: () {},
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

              SizedBox(height: _isMobile(context) ? 16 : 24),
            ],
          ),
        ),
      ),
    );
  }
}
