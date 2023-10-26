import 'package:appk_flutter/models/expense_model.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/viewmodels/expense_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseConfirmSheet extends StatefulWidget {
  const ExpenseConfirmSheet(
      {super.key, required this.docID, required this.desc});
  final String docID;
  final String desc;

  @override
  State<ExpenseConfirmSheet> createState() => _ExpenseConfirmSheetState();
}

class _ExpenseConfirmSheetState extends State<ExpenseConfirmSheet> {
  String docid = '';
  String itemDesc = '';
  final UserController userC = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    docid = widget.docID;
    itemDesc = widget.desc;
  }

  // final Expense showData = Expense(id: id, userId: userId, itemDescription: itemDescription, expensesCategory: expensesCategory, categoryDescription: categoryDescription, date: date, year: year, month: month, itemPrice: itemPrice)
  @override
  Widget build(BuildContext context) {
    final ExpenseViewModel expenseVm =
        Get.put(ExpenseViewModel(userC.uid.value));

    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Delete $itemDesc?"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff26619C)),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff26619C)),
                  onPressed: () {
                    expenseVm.deleteExpense(docid);
                    Get.back();
                    Get.snackbar("Success", "$itemDesc Deleted",
                        backgroundColor: Colors.white,
                        icon: const Icon(Icons.verified_rounded));
                  },
                  child: const Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
