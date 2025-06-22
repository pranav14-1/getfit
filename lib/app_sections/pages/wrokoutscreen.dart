import 'package:flutter/material.dart';

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
      body: Center(child: Text('Workout Screen')),
    );
  }
}
