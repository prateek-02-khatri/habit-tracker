import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view/stats/stats_screen.dart';
import 'package:habit_tracker_app/view/home/home_screen.dart';
import 'package:habit_tracker_app/view/profile/profile_screen.dart';
import 'package:habit_tracker_app/view/progress/progress_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ProgressScreen(),
    const StatsScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,

        iconSize: 30,
        selectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600
        ),

        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Progress'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              label: 'Stats'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}
