import 'package:appk_flutter/screens/add_expense.dart';
import 'package:appk_flutter/screens/home.dart';
import 'package:appk_flutter/screens/list_expenses.dart';
import 'package:appk_flutter/screens/login_screen.dart';
import 'package:appk_flutter/screens/planner.dart';
import 'package:appk_flutter/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInHandler extends StatefulWidget {
  const LoggedInHandler({super.key});

  @override
  State<LoggedInHandler> createState() => _LoggedInHandlerState();
}

class _LoggedInHandlerState extends State<LoggedInHandler> {
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
              print(index);
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
            ]),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('something went wrong'),
              );
            } else if (snapshot.hasData) {
              return _screens[_currentIndex];
            } else {
              return const LoginScreen();
            }

            // if (snapshot.hasData) {
            //   return const HomeScreen();
            // } else {
            //   return const LoginScreen();
            // }
          },
        ));
  }
}
