import 'package:appk_flutter/models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  
  var selectedExpense = Expense(
    id: '', 
    userId: '',
    itemDescription: '',
    expensesCategory: '',
    categoryDescription: '',
    date: '',
    year: '',
    month: '',
    itemPrice: 0,
  ).obs;

  void updateSelectedExpense(Expense expense) {
    selectedExpense.value = expense;
  }
}
