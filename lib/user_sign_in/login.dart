import 'package:flutter/material.dart';
import 'package:getfit/app_sections/pages/homescreen.dart';
import 'package:getfit/components/colors.dart';
import 'package:getfit/user_sign_in/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool _obscurePassword = true;

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
        obscureText: isPassword ? _obscurePassword : false,
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
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                    size: _isMobile(context) ? 20 : 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
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
                        "Welcome Back!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 24),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sign in to continue your fitness journey",
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

                // Login Form Container
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
                        "Sign In",
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 20),
                        ),
                      ),
                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Username Field
                      _buildInputField(
                        label: 'Username or Email',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: _isMobile(context) ? 16 : 20),

                      // Password Field
                      _buildInputField(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),

                      SizedBox(height: _isMobile(context) ? 12 : 16),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.buttons,
                              fontSize: _getResponsiveFontSize(context, 12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: _isMobile(context) ? 20 : 24),

                      // Login Button
                      _buildButton(
                        text: 'Sign In',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homescreen(),
                            ),
                          );
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
                              "Or continue with",
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

                      // Social Login Buttons
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

                      // Sign Up Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: _getResponsiveFontSize(context, 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Join us',
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
