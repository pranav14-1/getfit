import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:getfit/components/colors.dart';
import 'package:getfit/app_sections/pages/nutritionscreen.dart';
import 'package:getfit/app_sections/pages/wrokoutscreen.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  // Navigation state
  int selectedIndex = 1; // Start with home selected
  late AnimationController _animationController;

  String? svgContent;

  // 🏋️ Set counts per body part for this week
  final Map<String, int> setData = {
    'shoulder_1': 12,
    'shoulder_2': 12,
    'shoulder_3': 12,
    'shoulder_4': 12,
    'trap_1': 6,
    'trap_2': 6,
    'bicep_1': 10,
    'bicep_2': 10,
    'bicep_3': 10,
    'bicep_4': 10,
    'triceps_1': 8,
    'triceps_2': 8,
    'triceps_3': 8,
    'triceps_4': 8,
    'chest_1': 15,
    'chest_2': 15,
    'abs_1': 14,
    'abs_2': 14,
    'abs_3': 14,
    'abs_4': 14,
    'lats_1': 13,
    'lats_2': 13,
    'upper_back_1': 11,
    'upper_back_2': 11,
    'lower_back_1': 7,
    'lower_back_2': 7,
    'glutes_1': 6,
    'glutes_2': 6,
    'hamstring_1': 5,
    'hamstring_2': 5,
    'hamstring_3': 5,
    'hamstring_4': 5,
    'quad_1': 6,
    'quad_2': 6,
    'quad_3': 6,
    'quad_4': 6,
    'quad_5': 6,
    'quad_6': 6,
    'aductor_1': 5,
    'aductor_2': 5,
    'aductor_3': 5,
    'aductor_4': 5,
    'forearm_1': 7,
    'forearm_2': 7,
    'forearm_3': 7,
    'forearm_4': 7,
    'forearm_5': 7,
    'forearm_6': 7,
    'forearm_7': 7,
    'forearm_8': 7,
    'calves_1': 8,
    'calves_2': 8,
    'calves_3': 8,
    'calves_4': 8,
    'calves_5': 8,
    'calves_6': 8,
    'calves_7': 8,
    'calves_8': 8,
    'knee_1': 3,
    'knee_2': 3,
    'feet_1': 2,
    'feet_2': 2,
    'head_1': 1,
    'head_2': 1,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    loadAndModifySvg();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Create pages list as a getter instead of initializing in initState
  List<Widget> get pages => [
    Workoutscreen(),
    _buildHomeContent(),
    Nutritionscreen(),
  ];

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

  Color _getColorForSets(int sets) {
    if (sets >= 15) return Colors.red.shade900;
    if (sets >= 10) return Colors.red.shade600;
    if (sets >= 5) return Colors.red.shade300;
    if (sets >= 1) return Colors.red.shade100;
    return Colors.grey.shade300;
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  Future<void> loadAndModifySvg() async {
    String rawSvg = await rootBundle.loadString('assets/images/heatmap.svg');

    setData.forEach((id, sets) {
      final color = _colorToHex(_getColorForSets(sets));

      rawSvg = rawSvg.replaceAllMapped(
        RegExp(r'<path[^>]*id="' + id + r'"[^>]*>', caseSensitive: false),
        (match) {
          final tag = match.group(0)!;
          if (tag.contains('fill=')) {
            return tag.replaceAll(RegExp(r'fill="[^"]*"'), 'fill="$color"');
          } else {
            return tag.replaceFirst('id="$id"', 'id="$id" fill="$color"');
          }
        },
      );
    });

    setState(() {
      svgContent = rawSvg;
    });
  }

  // Helper method for the legend items
  Widget _buildLegendItem(String label, Color color, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _isMobile(context) ? 10 : 12,
          height: _isMobile(context) ? 10 : 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: _isMobile(context) ? 3 : 4),
        Text(
          label,
          style: TextStyle(
            fontSize: _isMobile(context) ? 10 : 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // Responsive circular indicator
  Widget _buildResponsiveCircularIndicator({
    required BuildContext context,
    required double percent,
    required Color progressColor,
    required IconData icon,
    required String title,
    required String subtitle,
    required String percentage,
  }) {
    final radius = _isMobile(context)
        ? 40.0
        : _isTablet(context)
        ? 50.0
        : 60.0;
    final iconSize = _isMobile(context) ? 16.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
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
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: radius,
            lineWidth: _isMobile(context) ? 6 : 8,
            percent: percent,
            progressColor: progressColor,
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: progressColor, size: iconSize),
                Text(
                  percentage,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _isMobile(context) ? 10 : 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _isMobile(context) ? 8 : 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: _isMobile(context) ? 12 : 14,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: _isMobile(context) ? 10 : 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // Extract the original home content into a separate method
  Widget _buildHomeContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = _getResponsivePadding(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _getResponsiveFontSize(context, 20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ready to crush your goals today?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: _getResponsiveFontSize(context, 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(_isMobile(context) ? 6 : 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: _isMobile(context) ? 20 : 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: _isMobile(context) ? 16 : 24),

            // Muscle Heatmap Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
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
              child: Column(
                children: [
                  // Simple header with fixed "This Week" badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Workout Distribution',
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: _isMobile(context) ? 12 : 16,
                          vertical: _isMobile(context) ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Text(
                          'This Week',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: _isMobile(context) ? 10 : 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _isMobile(context) ? 16 : 20),
                  Center(
                    child: svgContent == null
                        ? Container(
                            height:
                                screenHeight *
                                (_isMobile(context) ? 0.25 : 0.35),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: _isMobile(context) ? 12 : 16,
                                  ),
                                  Text(
                                    'Loading muscle map...',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: _getResponsiveFontSize(
                                        context,
                                        12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SvgPicture.string(
                            svgContent!,
                            height:
                                screenHeight *
                                (_isMobile(context)
                                    ? 0.25
                                    : _isTablet(context)
                                    ? 0.3
                                    : 0.35),
                            width:
                                screenWidth * (_isMobile(context) ? 0.6 : 0.5),
                            fit: BoxFit.contain,
                          ),
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  // Legend - responsive layout
                  _isMobile(context)
                      ? Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildLegendItem(
                              'Low',
                              Colors.red.shade100,
                              context,
                            ),
                            _buildLegendItem(
                              'Medium',
                              Colors.red.shade300,
                              context,
                            ),
                            _buildLegendItem(
                              'High',
                              Colors.red.shade600,
                              context,
                            ),
                            _buildLegendItem(
                              'Intense',
                              Colors.red.shade900,
                              context,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildLegendItem(
                              'Low',
                              Colors.red.shade100,
                              context,
                            ),
                            _buildLegendItem(
                              'Medium',
                              Colors.red.shade300,
                              context,
                            ),
                            _buildLegendItem(
                              'High',
                              Colors.red.shade600,
                              context,
                            ),
                            _buildLegendItem(
                              'Intense',
                              Colors.red.shade900,
                              context,
                            ),
                          ],
                        ),
                ],
              ),
            ),

            SizedBox(height: _isMobile(context) ? 16 : 24),

            // Quick Stats Section
            Text(
              'Today\'s Progress',
              style: TextStyle(
                color: AppColors.font1,
                fontWeight: FontWeight.bold,
                fontSize: _getResponsiveFontSize(context, 18),
              ),
            ),
            SizedBox(height: _isMobile(context) ? 12 : 16),

            // Responsive grid for progress indicators
            _isDesktop(context)
                ? Row(
                    children: [
                      Expanded(
                        child: _buildResponsiveCircularIndicator(
                          context: context,
                          percent: 0.4,
                          progressColor: Colors.orange.shade600,
                          icon: Icons.local_fire_department,
                          title: 'Calories',
                          subtitle: '450/1200',
                          percentage: '40%',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildResponsiveCircularIndicator(
                          context: context,
                          percent: 0.7,
                          progressColor: Colors.blue.shade600,
                          icon: Icons.directions_walk,
                          title: 'Steps',
                          subtitle: '7,230/10,000',
                          percentage: '70%',
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildResponsiveCircularIndicator(
                              context: context,
                              percent: 0.4,
                              progressColor: Colors.orange.shade600,
                              icon: Icons.local_fire_department,
                              title: 'Calories',
                              subtitle: '450/1200',
                              percentage: '40%',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildResponsiveCircularIndicator(
                              context: context,
                              percent: 0.7,
                              progressColor: Colors.blue.shade600,
                              icon: Icons.directions_walk,
                              title: 'Steps',
                              subtitle: '7,230/10,000',
                              percentage: '70%',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

            SizedBox(height: _isMobile(context) ? 16 : 24),

            // Quick Action Buttons
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(_isMobile(context) ? 16 : 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      color: AppColors.font1,
                      fontWeight: FontWeight.bold,
                      fontSize: _getResponsiveFontSize(context, 16),
                    ),
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  // Responsive button layout
                  _isMobile(context)
                      ? Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttons,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.fitness_center, size: 18),
                                label: Text('Start Workout'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.restaurant, size: 18),
                                label: Text('Log Meal'),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttons,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.fitness_center, size: 18),
                                label: Text('Start Workout'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.restaurant, size: 18),
                                label: Text('Log Meal'),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 1
          ? AppBar(
              title: Text(
                'GetFit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _getResponsiveFontSize(context, 26),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.logout, size: _isMobile(context) ? 22 : 24),
                ),
              ],
            )
          : null,
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) async {
              _animationController.forward();
              await Future.delayed(const Duration(milliseconds: 150));
              _animationController.reverse();
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade400,
            selectedFontSize: _isMobile(context) ? 12 : 14,
            unselectedFontSize: _isMobile(context) ? 10 : 12,
            iconSize: _isMobile(context) ? 24 : 28,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(selectedIndex == 0 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    selectedIndex == 0
                        ? Icons.fitness_center
                        : Icons.fitness_center_outlined,
                  ),
                ),
                label: 'Workout',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(selectedIndex == 1 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    selectedIndex == 1
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(selectedIndex == 2 ? 8 : 4),
                  decoration: BoxDecoration(
                    color: selectedIndex == 2
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    selectedIndex == 2
                        ? Icons.restaurant
                        : Icons.restaurant_outlined,
                  ),
                ),
                label: 'Nutrition',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
