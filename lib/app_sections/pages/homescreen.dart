import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:getfit/components/colors.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? svgContent;

  // 🏋️ Set counts per body part (update as needed)
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
    'calves_2': 8,
    'calves_1': 8,
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

  @override
  void initState() {
    super.initState();
    loadAndModifySvg();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GetFit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: svgContent == null
                    ? const CircularProgressIndicator()
                    : SvgPicture.string(
                        svgContent!,
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.5,
                        fit: BoxFit.contain,
                      ),
              ),
              Text(
                'Workout Distribution',
                style: TextStyle(
                  color: AppColors.font1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 9,
                        percent: 0.4,
                        progressColor: Colors.black54,
                        backgroundColor: Colors.black38,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: const Text('Calorie Count'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 9,
                        percent: 0.7,
                        progressColor: Colors.black54,
                        backgroundColor: Colors.black38,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: const Text('Step Count'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
