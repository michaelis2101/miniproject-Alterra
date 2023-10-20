import 'package:appk_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userInformation = FirebaseAuth.instance.currentUser!;
  final UserController c = Get.put(UserController());
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.setUserUid(userInformation.uid);
  }

  Stream<int> getTodayExpensesStream() {
    final today = DateTime.now();
    final todayDate =
        today.day.toString(); 
    final todayMonth = today.month.toString(); 
    final todayYear = today.year.toString(); 

    return firestoreInstance
        .collection('expenses')
        .where('date', isEqualTo: todayDate)
        .where('month', isEqualTo: todayMonth)
        .where('year', isEqualTo: todayYear)
        .where('userId', isEqualTo: c.uid.toString())
        .snapshots()
        .map<int>((snapshot) {
      int total = 0;
      for (QueryDocumentSnapshot document in snapshot.docs) {
        final data = document.data()
            as Map<String, dynamic>; 
        if (data.containsKey('itemPrice')) {
          total += (data['itemPrice'] as int);
        }
      }
      return total;
    });
  }

  Stream<int> getMonthExpensesStream() {
    final today = DateTime.now();
    final todayMonth = today.month.toString(); 
    final todayYear = today.year.toString(); 

    return firestoreInstance
        .collection('expenses')
        .where('month', isEqualTo: todayMonth)
        .where('year', isEqualTo: todayYear)
        .where('userId', isEqualTo: c.uid.toString())
        .snapshots()
        .map<int>((snapshot) {
      int total = 0;
      for (QueryDocumentSnapshot document in snapshot.docs) {
        final data = document.data()
            as Map<String, dynamic>; // Cast to Map<String, dynamic>
        if (data.containsKey('itemPrice')) {
          total += (data['itemPrice'] as int);
        }
      }
      return total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff26619C),
        ),
        StreamBuilder<int>(
          stream: getTodayExpensesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final totalTodayExpenses = snapshot.data ?? 0;
              // print(totalTodayExpenses);
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total Today Expenses:',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff26619C))),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rp.$totalTodayExpenses.toString()}',
                              style: const TextStyle(
                                  fontSize: 35, color: Color(0xff26619C)),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
        StreamBuilder<int>(
          stream: getMonthExpensesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final totalMonthExpenses = snapshot.data ?? 0;
              // print(totalTodayExpenses);
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total This Month Expenses:',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff26619C))),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rp.${totalMonthExpenses.toString()}',
                              style: const TextStyle(
                                  fontSize: 30, color: Color(0xff26619C)),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
