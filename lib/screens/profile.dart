import 'package:appk_flutter/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userInformation = FirebaseAuth.instance.currentUser!;
  final UserController c = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.setUserUid(userInformation.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Email: ${userInformation.email!}')),
        Center(child: Text('uid: ${userInformation.uid}')),
        Center(child: Obx(() => Text('uid: ${c.uid}'))),
        ElevatedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text('LogOut'))
      ],
    );
  }
}
