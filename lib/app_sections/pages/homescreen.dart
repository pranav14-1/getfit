import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getfit/components/colors.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    //get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                child: SvgPicture.asset(
                  'assets/images/body_diagram1.svg',
                  height: screenHeight * 0.33,
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
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 9,
                        percent:
                            0.4, //later adjust according to user requirement
                        progressColor: Colors.black54,
                        backgroundColor: Colors.black38,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text('Calorie Count'),
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
                        center: Text('Step Count'),
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
