import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

import 'package:getfit/user_sign_in/login.dart';
import 'package:getfit/user_sign_in/signup.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade600,
                            Colors.green.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: _isMobile(context) ? 48 : 64,
                      ),
                    ),

                    SizedBox(height: _isMobile(context) ? 32 : 40),

                    // App Title
                    Text(
                      'GetFit',
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 36),
                        fontWeight: FontWeight.bold,
                        color: AppColors.font1,
                      ),
                    ),

                    SizedBox(height: _isMobile(context) ? 16 : 20),

                    // Subtitle
                    Text(
                      'Your personal fitness journey starts here',
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 16),
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: _isMobile(context) ? 48 : 64),

                    // Action Buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttons,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: _isMobile(context) ? 16 : 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: Colors.black.withOpacity(0.1),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: _isMobile(context) ? 16 : 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.buttons,
                          padding: EdgeInsets.symmetric(
                            vertical: _isMobile(context) ? 16 : 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: AppColors.buttons,
                              width: 2,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
