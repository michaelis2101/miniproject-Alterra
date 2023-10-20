import 'package:appk_flutter/screens/add_expense.dart';
import 'package:appk_flutter/screens/home.dart';
import 'package:appk_flutter/screens/list_expenses.dart';
import 'package:appk_flutter/screens/planner.dart';
import 'package:appk_flutter/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ScreenHandler extends StatefulWidget {
  const ScreenHandler({super.key});

  @override
  State<ScreenHandler> createState() => ScreenHandlerState();
}

class ScreenHandlerState extends State<ScreenHandler> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ListExpenses(),
    const AddExpenses(),
    const Planner(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xff26619C),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          // print(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.list_rounded),
          Icon(Icons.add),
          Icon(Icons.chat_rounded),
          Icon(Icons.person_rounded),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
