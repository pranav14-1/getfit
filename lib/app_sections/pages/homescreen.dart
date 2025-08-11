import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:getfit/app_sections/sections/profile_screen.dart';
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

  // Chat messages list
  final List<Map<String, dynamic>> _chatMessages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

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

  // Sample workouts data
  final List<Map<String, dynamic>> exploreWorkouts = [
    {
      'name': 'HIIT Training',
      'duration': '20 min',
      'difficulty': 'High',
      'icon': Icons.flash_on,
      'color': Colors.orange.shade600,
    },
    {
      'name': 'Strength Training',
      'duration': '45 min',
      'difficulty': 'Medium',
      'icon': Icons.fitness_center,
      'color': Colors.blue.shade600,
    },
    {
      'name': 'Yoga Flow',
      'duration': '30 min',
      'difficulty': 'Low',
      'icon': Icons.self_improvement,
      'color': Colors.green.shade600,
    },
  ];

  // Sample meals data
  final List<Map<String, dynamic>> exploreMeals = [
    {
      'name': 'Protein Bowl',
      'calories': '420 cal',
      'time': 'Breakfast',
      'icon': Icons.rice_bowl,
      'color': Colors.green.shade600,
    },
    {
      'name': 'Chicken Salad',
      'calories': '350 cal',
      'time': 'Lunch',
      'icon': Icons.dinner_dining,
      'color': Colors.orange.shade600,
    },
    {
      'name': 'Smoothie Bowl',
      'calories': '280 cal',
      'time': 'Snack',
      'icon': Icons.local_drink,
      'color': Colors.purple.shade600,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    loadAndModifySvg();
    _initializeChatMessages();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  void _initializeChatMessages() {
    _chatMessages.addAll([
      {
        'text':
            'Hello! I\'m your AI Fitness Coach. I can help you with workout routines, nutrition advice, and motivation. How can I assist you today?',
        'isUser': false,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        'text': 'Hi! Can you suggest a workout for today?',
        'isUser': true,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 4)),
      },
      {
        'text':
            'I\'d be happy to help! This feature is currently in development. Soon I\'ll be able to create personalized workout plans based on your fitness level and goals.',
        'isUser': false,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
      },
    ]);
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

  Widget _buildWorkoutCard(Map<String, dynamic> workout) {
    final String name = workout['name'] ?? 'Unknown Workout';
    final String duration = workout['duration'] ?? '0 min';
    final String difficulty = workout['difficulty'] ?? 'Medium';
    final IconData icon = workout['icon'] ?? Icons.fitness_center;
    final Color color = workout['color'] ?? Colors.blue.shade600;

    final cardWidth = _isMobile(context)
        ? 130.0
        : _isTablet(context)
        ? 150.0
        : 170.0;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedIndex = 0; // Navigate to workout screen
            });
          },
          child: Container(
            height: _isMobile(context) ? 120 : 140,
            padding: EdgeInsets.all(_isMobile(context) ? 10 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: _getResponsiveFontSize(context, 11),
                          color: AppColors.font1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 9),
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 8),
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    final String name = meal['name'] ?? 'Unknown Meal';
    final String calories = meal['calories'] ?? '0 cal';
    final String time = meal['time'] ?? 'Anytime';
    final IconData icon = meal['icon'] ?? Icons.restaurant;
    final Color color = meal['color'] ?? Colors.green.shade600;

    final cardWidth = _isMobile(context)
        ? 130.0
        : _isTablet(context)
        ? 150.0
        : 170.0;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedIndex = 2; // Navigate to nutrition screen
            });
          },
          child: Container(
            height: _isMobile(context) ? 120 : 140,
            padding: EdgeInsets.all(_isMobile(context) ? 10 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: _getResponsiveFontSize(context, 11),
                          color: AppColors.font1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        calories,
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 9),
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 8),
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FIXED: Floating Action Button for Chatbot - No overflow
  Widget _buildChatbotFAB() {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 80 : 90),
      child: FloatingActionButton(
        onPressed: () {
          _showChatbotBottomSheet();
        },
        backgroundColor: Colors.green.shade600,
        elevation: 4,
        child: Icon(
          Icons.smart_toy_outlined,
          color: Colors.white,
          size: 20, // Reduced size to prevent overflow
        ),
        tooltip: 'FitBot - AI Coach',
      ),
    );
  }

  // Send message function
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _chatMessages.add({
        'text': userMessage,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _chatMessages.add({
          'text':
              'Thanks for your message! I\'m still learning and this feature will be enhanced with AI capabilities soon. Stay tuned for personalized fitness advice!',
          'isUser': false,
          'timestamp': DateTime.now(),
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  // IMPROVED: ChatGPT-style chat interface
  void _showChatbotBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50, // ChatGPT-style background
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // IMPROVED: Header with better styling
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade600,
                            Colors.green.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.smart_toy_outlined,
                        color: Colors.white,
                        size: 20, // Consistent sizing
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FitBot',
                            style: TextStyle(
                              color: AppColors.font1,
                              fontWeight: FontWeight.bold,
                              fontSize: _getResponsiveFontSize(context, 18),
                            ),
                          ),
                          Text(
                            'Online • Your personal assistant',
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontSize: _getResponsiveFontSize(context, 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              // IMPROVED: Chat Content
              Expanded(child: _buildImprovedChatContent()),
            ],
          ),
        ),
      ),
    );
  }

  // IMPROVED: ChatGPT-style chat content
  Widget _buildImprovedChatContent() {
    return Column(
      children: [
        // Coming Soon Notice - More subtle
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Currently in development.',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: _getResponsiveFontSize(context, 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        // IMPROVED: Messages with ChatGPT-style bubbles
        Expanded(
          child: ListView.builder(
            controller: _chatScrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              return _buildImprovedChatMessage(_chatMessages[index]);
            },
          ),
        ),

        // IMPROVED: Input Area with better styling
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Message FitBot...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    enabled: true, // Enable for demo
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // IMPROVED: ChatGPT-style message bubbles
  Widget _buildImprovedChatMessage(Map<String, dynamic> message) {
    final bool isUser = message['isUser'];
    final String text = message['text'];
    final DateTime timestamp = message['timestamp'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade600, Colors.green.shade400],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.green.shade600 : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: isUser
                          ? const Radius.circular(20)
                          : const Radius.circular(4),
                      bottomRight: isUser
                          ? const Radius.circular(4)
                          : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: _getResponsiveFontSize(context, 14),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 16),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(
              left: isUser ? 0 : 40,
              right: isUser ? 40 : 0,
            ),
            child: Text(
              _formatTime(timestamp),
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: _getResponsiveFontSize(context, 11),
              ),
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

            // Explore Workouts Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Workouts',
                  style: TextStyle(
                    color: AppColors.font1,
                    fontWeight: FontWeight.bold,
                    fontSize: _getResponsiveFontSize(context, 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.buttons,
                      fontSize: _getResponsiveFontSize(context, 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _isMobile(context) ? 12 : 16),

            // Workouts horizontal list with proper constraints
            SizedBox(
              height: _isMobile(context) ? 120 : 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: exploreWorkouts.length,
                itemBuilder: (context, index) {
                  return _buildWorkoutCard(exploreWorkouts[index]);
                },
              ),
            ),

            SizedBox(height: _isMobile(context) ? 16 : 24),

            // Explore Meals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Meals',
                  style: TextStyle(
                    color: AppColors.font1,
                    fontWeight: FontWeight.bold,
                    fontSize: _getResponsiveFontSize(context, 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.buttons,
                      fontSize: _getResponsiveFontSize(context, 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: _isMobile(context) ? 12 : 16),

            // Meals horizontal list with proper constraints
            SizedBox(
              height: _isMobile(context) ? 120 : 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: exploreMeals.length,
                itemBuilder: (context, index) {
                  return _buildMealCard(exploreMeals[index]);
                },
              ),
            ),

            SizedBox(height: _isMobile(context) ? 16 : 24),
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
              automaticallyImplyLeading: false,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person_2_outlined,
                    size: _isMobile(context) ? 22 : 24,
                  ),
                ),
              ],
            )
          : null,
      body: pages[selectedIndex],

      // FIXED: Floating action button with proper sizing - no overflow
      floatingActionButton: selectedIndex == 1 ? _buildChatbotFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
