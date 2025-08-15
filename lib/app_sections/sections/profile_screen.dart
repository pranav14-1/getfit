import 'package:flutter/material.dart';
import 'package:getfit/app_sections/sections/profile_features/edit_profile.dart';
import 'package:getfit/app_sections/sections/profile_features/progress_stats.dart';
import 'package:getfit/app_sections/sections/profile_features/workout_preference.dart';
import 'package:provider/provider.dart';
import 'package:getfit/components/colors.dart';
import 'package:getfit/components/theme_provider.dart';
import 'package:getfit/app_sections/sections/landing_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

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

  // Profile option card
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.buttons).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.buttons,
                      size: _isMobile(context) ? 20 : 24,
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
                            color: AppColors.font1,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 12),
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  trailing ??
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.dividerColor,
            indent: _isMobile(context) ? 52 : 60,
          ),
      ],
    );
  }

  // Stats card
  Widget _buildStatsCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
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
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _getResponsiveFontSize(context, 18),
                color: AppColors.font1,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 12),
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Logout confirmation dialog
  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _getResponsiveFontSize(context, 18),
              color: AppColors.font1,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: AppColors.textSecondary,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: _getResponsiveFontSize(context, 14),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getResponsiveFontSize(context, 14),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
            ),
          ],
        );
      },
    );
  }

  // Perform logout function
  void _performLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LandingScreen()),
      (Route<dynamic> route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged out successfully'),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Navigate to Edit Profile Screen
  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
  }

  // Navigate to Workout Preferences Screen
  void _navigateToWorkoutPreferences() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkoutPreferencesScreen()),
    );
  }

  // Navigate to Progress & Stats Screen
  void _navigateToProgressStats() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProgressStatsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
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
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(_isMobile(context) ? 20 : 24),
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
                  children: [
                    // Profile Picture
                    Container(
                      width: _isMobile(context) ? 80 : 100,
                      height: _isMobile(context) ? 80 : 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: _isMobile(context) ? 40 : 50,
                      ),
                    ),
                    SizedBox(height: _isMobile(context) ? 16 : 20),
                    Text(
                      'Pranav',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _getResponsiveFontSize(context, 20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'pranav@email.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // Stats Row
              Row(
                children: [
                  _buildStatsCard(
                    'Workouts',
                    '127',
                    Icons.fitness_center,
                    Colors.orange.shade600,
                  ),
                  const SizedBox(width: 12),
                  _buildStatsCard(
                    'Streak',
                    '15 days',
                    Icons.local_fire_department,
                    Colors.red.shade600,
                  ),
                ],
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // Settings Section
              Container(
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
                  children: [
                    // Edit Profile - Updated with navigation
                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      subtitle: 'Update your personal information',
                      onTap: _navigateToEditProfile,
                    ),

                    // Theme Toggle
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return _buildProfileOption(
                          icon: Icons.palette_outlined,
                          title: 'Theme',
                          subtitle: themeProvider.isDarkMode
                              ? 'Dark mode'
                              : 'Light mode',
                          trailing: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                            },
                            activeColor: AppColors.buttons,
                          ),
                          onTap: () {
                            themeProvider.toggleTheme();
                          },
                        );
                      },
                    ),

                    // Notifications Toggle
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: _notificationsEnabled ? 'Enabled' : 'Disabled',
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                        activeColor: AppColors.buttons,
                      ),
                    ),

                    // Workout Preferences - Updated with navigation
                    _buildProfileOption(
                      icon: Icons.fitness_center,
                      title: 'Workout Preferences',
                      subtitle: 'Set your fitness goals',
                      onTap: _navigateToWorkoutPreferences,
                    ),

                    // Progress & Stats - Updated with navigation
                    _buildProfileOption(
                      icon: Icons.bar_chart_outlined,
                      title: 'Progress & Stats',
                      subtitle: 'View detailed analytics',
                      onTap: _navigateToProgressStats,
                    ),

                    // Logout
                    _buildProfileOption(
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: 'Sign out of your account',
                      iconColor: Colors.red.shade600,
                      onTap: _showLogoutDialog,
                      showDivider: false,
                    ),
                  ],
                ),
              ),

              SizedBox(height: _isMobile(context) ? 20 : 24),

              // App Version
              Text(
                'GetFit v1.0.0',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: _getResponsiveFontSize(context, 12),
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
