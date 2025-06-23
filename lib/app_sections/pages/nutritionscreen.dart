import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daily Macros',
                    style: TextStyle(
                      color: AppColors.font1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 9,
                          percent:
                              0.4, //later adjust according to user requirement
                          progressColor: Colors.black54,
                          backgroundColor: Colors.black38,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text('Protein'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 9,
                          percent: 0.7,
                          progressColor: Colors.black54,
                          backgroundColor: Colors.black38,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text('Carbs'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 9,
                          percent: 0.2,
                          progressColor: Colors.black54,
                          backgroundColor: Colors.black38,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text('Fats'),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2, height: 60),
                Column(
                  children: [
                    Text(
                      'Log Intake',
                      style: TextStyle(
                        color: AppColors.font1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Whole Foods',
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Add your food',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter the quantity in grams',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Beverages',
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Add your drink',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter the quantity in ml',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                          'Add Calories Intake',
                          style: TextStyle(color: AppColors.font2),
                        ),
                      ),
                    ),
                    Divider(thickness: 2, height: 60),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Diet History',
                        style: TextStyle(
                          color: AppColors.font1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
