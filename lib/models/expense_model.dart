class Expense {
  final String id;
  final String userId;
  final String itemDescription;
  final String expensesCategory;
  final String categoryDescription;
  final String date;
  final String year;
  final String month;
  final int itemPrice;

  Expense({
    required this.id,
    required this.userId,
    required this.itemDescription,
    required this.expensesCategory,
    required this.categoryDescription,
    required this.date,
    required this.year,
    required this.month,
    required this.itemPrice,
  });
}
