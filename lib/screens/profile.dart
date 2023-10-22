import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/screens/wishlist.dart';
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: Container(
              height: 320,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xff26619C),
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    userInformation.email!,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${c.uid}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 1, color: Colors.white.withOpacity(0.5))),
            child: ListTile(
              title: const Text(
                'WishList',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              onTap: () {
                Get.to(() => const WishlistScreen());
              },
            ),
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 1, color: Colors.white.withOpacity(0.5))),
            child: ListTile(
              title: const Text(
                'News/?',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.newspaper,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              onTap: () {},
            ),
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 1, color: Colors.white.withOpacity(0.5))),
            child: ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ),

          // Center(child: Text('Email: ${userInformation.email!}')),
          // Center(child: Text('uid: ${userInformation.uid}')),
          // Center(child: Obx(() => Text('uid: ${c.uid}'))),
          // ElevatedButton(
          //     onPressed: () => FirebaseAuth.instance.signOut(),
          //     child: const Text('LogOut'))
        ],
      ),
    );
  }
}
