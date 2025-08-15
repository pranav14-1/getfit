import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

class WorkoutPreferencesScreen extends StatefulWidget {
  const WorkoutPreferencesScreen({super.key});

  @override
  State<WorkoutPreferencesScreen> createState() => _WorkoutPreferencesScreenState();
}

class _WorkoutPreferencesScreenState extends State<WorkoutPreferencesScreen> {
  String _selectedFitnessLevel = 'Intermediate';
  String _primaryGoal = 'Build Muscle';
  List<String> _selectedMuscleGroups = ['Chest', 'Back'];
  int _workoutDuration = 45;
  int _workoutsPerWeek = 4;
  bool _includeCardio = true;
  bool _includeStretching = true;

  // Responsive breakpoints (same as profile screen)
  bool _isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 768;
  bool _isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;

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

  // Option card widget (similar to profile screen)
  Widget _buildOptionCard({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 12 : 16),
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
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: _getResponsiveFontSize(context, 16),
              color: AppColors.font1,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 12),
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // Dropdown selection widget
  Widget _buildDropdownCard(String title, String value, List<String> options, Function(String?) onChanged) {
    return _buildOptionCard(
      title: title,
      subtitle: 'Select your $title',
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.buttons, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: AppColors.font1,
                fontSize: _getResponsiveFontSize(context, 14),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Theme.of(context).cardTheme.color,
      ),
    );
  }

  // Muscle group selection widget
  Widget _buildMuscleGroupSelection() {
    final muscleGroups = ['Chest', 'Back', 'Shoulders', 'Arms', 'Abs', 'Legs', 'Glutes'];
    
    return _buildOptionCard(
      title: 'Focus Areas',
      subtitle: 'Select muscle groups to focus on',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: muscleGroups.map((group) {
          final isSelected = _selectedMuscleGroups.contains(group);
          return FilterChip(
            label: Text(
              group,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.font1,
                fontSize: _getResponsiveFontSize(context, 12),
              ),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedMuscleGroups.add(group);
                } else {
                  _selectedMuscleGroups.remove(group);
                }
              });
            },
            backgroundColor: Theme.of(context).cardTheme.color,
            selectedColor: AppColors.buttons,
            checkmarkColor: Colors.white,
            side: BorderSide(color: isSelected ? AppColors.buttons : AppColors.dividerColor),
          );
        }).toList(),
      ),
    );
  }

  // Slider card widget
  Widget _buildSliderCard(String title, String subtitle, int value, int min, int max, String unit, Function(double) onChanged) {
    return _buildOptionCard(
      title: title,
      subtitle: subtitle,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$min $unit',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: _getResponsiveFontSize(context, 12),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.buttons.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$value $unit',
                  style: TextStyle(
                    color: AppColors.buttons,
                    fontWeight: FontWeight.w600,
                    fontSize: _getResponsiveFontSize(context, 14),
                  ),
                ),
              ),
              Text(
                '$max $unit',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: _getResponsiveFontSize(context, 12),
                ),
              ),
            ],
          ),
          Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            activeColor: AppColors.buttons,
            inactiveColor: AppColors.buttons.withOpacity(0.3),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Toggle option widget
  Widget _buildToggleOption(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 8 : 12),
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
      child: Row(
        children: [
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
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 12),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.buttons,
          ),
        ],
      ),
    );
  }

  // Save preferences function
  void _savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Workout preferences saved successfully!'),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
          'Workout Preferences',
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
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
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
                      Icons.fitness_center,
                      color: Colors.white,
                      size: _isMobile(context) ? 40 : 50,
                    ),
                    SizedBox(height: _isMobile(context) ? 12 : 16),
                    Text(
                      'Set Your Fitness Goals',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _getResponsiveFontSize(context, 20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Customize your workout experience',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                  ],
                ),
              ),

              _buildSectionHeader('Basic Information'),

              _buildDropdownCard(
                'Fitness Level',
                _selectedFitnessLevel,
                ['Beginner', 'Intermediate', 'Advanced'],
                (String? newValue) {
                  setState(() {
                    _selectedFitnessLevel = newValue!;
                  });
                },
              ),

              _buildDropdownCard(
                'Primary Goal',
                _primaryGoal,
                ['Lose Weight', 'Build Muscle', 'Maintain Fitness', 'Improve Endurance'],
                (String? newValue) {
                  setState(() {
                    _primaryGoal = newValue!;
                  });
                },
              ),

              _buildSectionHeader('Workout Details'),

              _buildMuscleGroupSelection(),

              _buildSliderCard(
                'Workout Duration',
                'How long do you want to exercise?',
                _workoutDuration,
                15,
                120,
                'minutes',
                (double value) {
                  setState(() {
                    _workoutDuration = value.round();
                  });
                },
              ),

              _buildSliderCard(
                'Workouts Per Week',
                'How often do you want to workout?',
                _workoutsPerWeek,
                1,
                7,
                'days',
                (double value) {
                  setState(() {
                    _workoutsPerWeek = value.round();
                  });
                },
              ),

              _buildSectionHeader('Additional Options'),

              _buildToggleOption(
                'Include Cardio',
                'Add cardiovascular exercises to your routine',
                _includeCardio,
                (bool value) {
                  setState(() {
                    _includeCardio = value;
                  });
                },
              ),

              _buildToggleOption(
                'Include Stretching',
                'Add stretching and flexibility exercises',
                _includeStretching,
                (bool value) {
                  setState(() {
                    _includeStretching = value;
                  });
                },
              ),

              SizedBox(height: _isMobile(context) ? 24 : 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: _isMobile(context) ? 48 : 56,
                child: ElevatedButton(
                  onPressed: _savePreferences,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttons,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Save Preferences',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: _getResponsiveFontSize(context, 16),
                    ),
                  ),
                ),
              ),

              SizedBox(height: _isMobile(context) ? 16 : 20),
            ],
          ),
        ),
      ),
    );
  }
}
