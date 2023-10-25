import 'package:appk_flutter/models/expense_model.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ExpenseViewModel extends GetxController {
  final CollectionReference _expensesCollection =
      FirebaseFirestore.instance.collection('expenses');

  final String currentUserId;

  ExpenseViewModel(this.currentUserId);

  final currentTimestamp = Timestamp.now();

  RxList<Expense> expenses = <Expense>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final querySnapshot = await _expensesCollection
        .where('userId', isEqualTo: currentUserId)
        .get();
    expenses.value = querySnapshot.docs
        .map((doc) => Expense(
            id: doc.id,
            userId: doc['userId'],
            itemDescription: doc['itemDescription'],
            expensesCategory: doc['expensesCategory'],
            categoryDescription: doc['categoryDescription'],
            date: doc['date'],
            year: doc['year'],
            month: doc['month'],
            itemPrice: doc['itemPrice'].toInt(),
            createdAt: doc['createdAt']))
        .toList();
  }

  // Future<void> loadAllExpenses() async {
  //   final querySnapshot = await _expensesCollection
  //       .where('userId', isEqualTo: currentUserId)
  //       .get();
  //   expenses.value = querySnapshot.docs
  //       .map((doc) => Expense(
  //             id: doc.id,
  //             userId: doc['userId'],
  //             itemDescription: doc['itemDescription'],
  //             expensesCategory: doc['expensesCategory'],
  //             categoryDescription: doc['categoryDescription'],
  //             date: doc['date'],
  //             year: doc['year'],
  //             month: doc['month'],
  //             itemPrice: doc['itemPrice'].toInt(),
  //           ))
  //       .toList();
  // }

  Future<void> addExpense(Expense expense) async {
    await _expensesCollection.add({
      'userId': currentUserId, // Added userId field
      'itemDescription': expense.itemDescription,
      'expensesCategory': expense.expensesCategory,
      'categoryDescription': expense.categoryDescription,
      'date': expense.date,
      'year': expense.year,
      'month': expense.month,
      'itemPrice': expense.itemPrice,
      'createdAt': currentTimestamp
    });
    _loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _expensesCollection.doc(expense.id).update({
      'itemDescription': expense.itemDescription,
      'expensesCategory': expense.expensesCategory,
      'categoryDescription': expense.categoryDescription,
      'date': expense.date,
      'year': expense.year,
      'month': expense.month,
      'itemPrice': expense.itemPrice,
    });
    _loadExpenses();
  }

  Future<void> deleteExpense(String expenseId) async {
    await _expensesCollection.doc(expenseId).delete();
    _loadExpenses();
  }
}
