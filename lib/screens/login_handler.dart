import 'package:appk_flutter/screens/login_screen.dart';

import 'package:appk_flutter/screens/stack_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInHandler extends StatefulWidget {
  const LoggedInHandler({super.key});

  @override
  State<LoggedInHandler> createState() => _LoggedInHandlerState();
}

class _LoggedInHandlerState extends State<LoggedInHandler> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        } else if (snapshot.hasData) {
          return const ScreenHandler();
        } else {
          // Get.off(() => const LoginScreen());
          return const LoginScreen();
        }
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: const Color(0xff26619C),
  //       body: StreamBuilder(
  //         stream: FirebaseAuth.instance.authStateChanges(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           } else if (snapshot.hasError) {
  //             return const Center(
  //               child: Text('something went wrong'),
  //             );
  //           } else if (snapshot.hasData) {
  //             return const ScreenHandler();
  //           } else {
  //             // Get.off(() => const LoginScreen());
  //             return const LoginScreen();
  //           }
  //         },
  //       ));
  // }
}
