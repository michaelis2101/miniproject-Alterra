import 'package:appk_flutter/models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  // Initialize selectedExpense with default values for required fields
  var selectedExpense = Expense(
    id: '', // Provide default values or leave them empty as needed
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
