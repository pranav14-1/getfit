import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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

  // Custom input field matching home theme
  Widget _buildInputField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isConfirmPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword
            ? (isConfirmPassword ? _obscureConfirmPassword : _obscurePassword)
            : false,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: _getResponsiveFontSize(context, 14),
          color: AppColors.font1,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.grey.shade600,
            size: _isMobile(context) ? 20 : 24,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isConfirmPassword
                        ? (_obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility)
                        : (_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                    color: Colors.grey.shade600,
                    size: _isMobile(context) ? 20 : 24,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirmPassword) {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      } else {
                        _obscurePassword = !_obscurePassword;
                      }
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: _isMobile(context) ? 16 : 20,
            vertical: _isMobile(context) ? 16 : 18,
          ),
        ),
      ),
    );
  }

  // Custom button matching home theme
  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? AppColors.buttons),
          foregroundColor: textColor ?? Colors.white,
          elevation: isOutlined ? 0 : 2,
          padding: EdgeInsets.symmetric(vertical: _isMobile(context) ? 16 : 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isOutlined
                ? BorderSide(
                    color: backgroundColor ?? AppColors.buttons,
                    width: 2,
                  )
                : BorderSide.none,
          ),
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: _isMobile(context) ? 18 : 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight - 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Section with gradient background
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
                      Text(
                        "Join GetFit!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 24),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Start your fitness journey with us today",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: _getResponsiveFontSize(context, 14),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: _isMobile(context) ? 32 : 40),

                // Signup Form Container
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(_isMobile(context) ? 24 : 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 20),
                        ),
                      ),
                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Full Name Field
                      _buildInputField(
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: _isMobile(context) ? 16 : 20),

                      // Email Field
                      _buildInputField(
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: _isMobile(context) ? 16 : 20),

                      // Password Field
                      _buildInputField(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      SizedBox(height: _isMobile(context) ? 16 : 20),

                      // Confirm Password Field
                      _buildInputField(
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        isConfirmPassword: true,
                      ),

                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Signup Button
                      _buildButton(
                        text: 'Create Account',
                        onPressed: () {
                          // Handle signup
                        },
                        backgroundColor: AppColors.buttons,
                      ),

                      SizedBox(height: _isMobile(context) ? 24 : 32),

                      // Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Or sign up with",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: _getResponsiveFontSize(context, 12),
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Social Signup Buttons
                      _buildButton(
                        text: 'Continue with Google',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        textColor: AppColors.font1,
                        icon: Icons.g_mobiledata,
                        isOutlined: true,
                      ),

                      SizedBox(height: _isMobile(context) ? 12 : 16),

                      _buildButton(
                        text: 'Continue with Phone',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        textColor: AppColors.font1,
                        icon: Icons.phone_outlined,
                        isOutlined: true,
                      ),

                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Sign In Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: _getResponsiveFontSize(context, 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                ); // Go back to previous screen (Login or Landing)
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.buttons,
                                  fontSize: _getResponsiveFontSize(context, 14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: _isMobile(context) ? 20 : 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
