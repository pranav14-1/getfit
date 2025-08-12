import 'package:flutter/material.dart';

class AppColors {
  static bool _isDark = false;
  
  static Color get font1 => _isDark ? Colors.white : Colors.black87;
  static Color get font2 => _isDark ? Colors.black87 : Colors.white;
  static Color get buttons => _isDark ? Colors.green.shade400 : Colors.green.shade600;
  static Color get link => _isDark ? Colors.green.shade300 : Colors.green.shade700;
  static Color get background => _isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
  static Color get cardColor => _isDark ? const Color(0xFF1E1E1E) : Colors.white;
  static Color get textSecondary => _isDark ? const Color(0xFFBDBDBD) : const Color(0xFF757575);
  static Color get dividerColor => _isDark ? const Color(0xFF424242) : const Color(0xFFE0E0E0);
  
  static void setTheme(bool isDark) {
    _isDark = isDark;
  }
}
