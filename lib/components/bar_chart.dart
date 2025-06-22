import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BarChart extends StatelessWidget {
  final List<double> chart;
  const BarChart({super.key, required this.chart});

  List<String> last7dayslabel() {
    final today = DateTime.now();
    final formatter = DateFormat('E');
    return List.generate(7, (index) {
      final day = today.subtract(Duration(days: 6 - index));
      return formatter.format(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
