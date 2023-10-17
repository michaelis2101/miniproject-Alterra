import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userInformation = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('Email: ${userInformation.email!}')),
        Center(child: Text('uid: ${userInformation.uid}')),
        ElevatedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text('LogOut'))
      ],
    );
  }
}
