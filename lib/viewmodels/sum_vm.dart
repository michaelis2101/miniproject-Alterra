// import 'package:appk_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

class SumViewModel {
  final firestoreInstance = FirebaseFirestore.instance;

  Stream<int> getTodayExpensesStream(String userId) {
    final today = DateTime.now();
    final todayDate = today.day.toString();
    final todayMonth = today.month.toString();
    final todayYear = today.year.toString();

    return firestoreInstance
        .collection('expenses')
        .where('date', isEqualTo: todayDate)
        .where('month', isEqualTo: todayMonth)
        .where('year', isEqualTo: todayYear)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map<int>((snapshot) {
      int total = 0;
      for (QueryDocumentSnapshot document in snapshot.docs) {
        final data = document.data() as Map<String, dynamic>;
        if (data.containsKey('itemPrice')) {
          total += (data['itemPrice'] as int);
        }
      }
      return total;
    });
  }

  Stream<int> getMonthExpensesStream(String userId) {
    final today = DateTime.now();
    final todayMonth = today.month.toString();
    final todayYear = today.year.toString();

    return firestoreInstance
        .collection('expenses')
        .where('month', isEqualTo: todayMonth)
        .where('year', isEqualTo: todayYear)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map<int>((snapshot) {
      int total = 0;
      for (QueryDocumentSnapshot document in snapshot.docs) {
        final data = document.data() as Map<String, dynamic>;
        if (data.containsKey('itemPrice')) {
          total += (data['itemPrice'] as int);
        }
      }
      return total;
    });
  }
}
