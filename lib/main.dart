import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:getfit/components/theme_provider.dart';
import 'package:getfit/components/colors.dart';
import 'package:getfit/app_sections/sections/landing_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable only in debug mode
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Update AppColors when theme changes
        AppColors.setTheme(themeProvider.isDarkMode);
        
        return MaterialApp(
          title: 'GetFit',
          debugShowCheckedModeBanner: false,
          // These three properties are essential for DevicePreview to work properly
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode 
              ? ThemeMode.dark 
              : ThemeMode.light,
          home: const LandingScreen(),
        );
      },
    );
  }
}
