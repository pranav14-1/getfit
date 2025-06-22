import 'package:flutter/material.dart';

class Nutritionscreen extends StatefulWidget {
  const Nutritionscreen({super.key});

  @override
  State<Nutritionscreen> createState() => _NutritionscreenState();
}

class _NutritionscreenState extends State<Nutritionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Nutrition'), centerTitle: true),
      body: Center(child: Text('Nutrition Screen')),
    );
  }
}
