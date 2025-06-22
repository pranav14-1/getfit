import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class Workoutscreen extends StatefulWidget {
  const Workoutscreen({super.key});

  @override
  State<Workoutscreen> createState() => _WorkoutscreenState();
}

class _WorkoutscreenState extends State<Workoutscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Workout'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quick Start',
                    style: TextStyle(
                      color: AppColors.font1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttons,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Start Empty Workout', //start a fresh workout which won't be saved in the routine section
                      style: TextStyle(color: AppColors.font2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Routines',
                    style: TextStyle(
                      color: AppColors.font1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttons,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: Icon(Icons.note_add, color: Colors.white),
                        label: Text(
                          'New Routine', //create and store routine for using later
                          style: TextStyle(color: AppColors.font2),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttons,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: Icon(Icons.search, color: Colors.white),
                        label: Text(
                          'Explore', //wil lead to various workout styles and splits
                          style: TextStyle(color: AppColors.font2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Added workout will be stored here'),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Workout History will be displayed here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
