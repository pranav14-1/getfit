import 'package:flutter/material.dart';
import 'package:getfit/app_sections/pages/homescreen.dart';
import 'package:getfit/app_sections/pages/nutritionscreen.dart';
import 'package:getfit/app_sections/pages/wrokoutscreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 1;
  final List<Widget> pages = [Workoutscreen(), Homescreen(), Nutritionscreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) async {
          await Future.delayed(Duration(milliseconds: 200));
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.boy_outlined),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Nutrition',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
