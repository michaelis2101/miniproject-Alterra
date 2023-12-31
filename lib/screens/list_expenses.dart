import 'package:appk_flutter/components/confirmheet_ex.dart';
import 'package:appk_flutter/controller/update_controller.dart';
import 'package:appk_flutter/models/expense_model.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/screens/update_screen.dart';
import 'package:appk_flutter/viewmodels/expense_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListExpenses extends StatefulWidget {
  const ListExpenses({super.key});

  @override
  State<ListExpenses> createState() => _ListExpensesState();
}

class _ListExpensesState extends State<ListExpenses> {
  final UserController userC = Get.put(UserController());
  final ExpenseController expenseController = Get.put(ExpenseController());

  final ExpenseViewModel getVm =
      Get.put(ExpenseViewModel(userController.uid.value));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final Query _query = FirebaseFirestore.instance
    //     .collection('expenses')
    //     .where('userId', isEqualTo: userC.uid.toString())
    //     .orderBy('year', descending: false)
    //     .orderBy('month', descending: false)
    //     .orderBy('date', descending: false);

    // final Stream<QuerySnapshot> _usersStream = _query.snapshots();
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('expenses')
        .where('userId', isEqualTo: userC.uid.toString())
        .orderBy('createdAt', descending: true)
        .snapshots();

    final ExpenseViewModel expenseVm =
        Get.put(ExpenseViewModel(userC.uid.value));

    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              // child: Text("Data Empty"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                        width: 116.5,
                        height: 78.125,
                        child: Image.asset(
                          'assets/images/data-empty.png',
                        )),
                  ),
                  const Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Data is Empty',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  )
                ],
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String docId = document.id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Text(data['itemDescription']),
                      subtitle: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'IDR : ${data['itemPrice'].toString()}')),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Category ${data['categoryDescription'].toString()}'),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'date :${data['date']}-${data['month']}-${data['year']}'),
                          )
                        ],
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                final selectedExpense = Expense(
                                  id: docId,
                                  userId: data['userId'],
                                  itemDescription: data['itemDescription'],
                                  expensesCategory: data['expensesCategory'],
                                  categoryDescription:
                                      data['categoryDescription'],
                                  date: data['date'],
                                  year: data['year'],
                                  month: data['month'],
                                  itemPrice: data['itemPrice'],
                                );

                                expenseController
                                    .updateSelectedExpense(selectedExpense);

                                Get.to(() => const UpdateExpenses());
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                // expenseVm.deleteExpense(docId);
                                // Get.snackbar('Succedd', 'Item Deleted',
                                //     backgroundColor: Colors.white,
                                //     icon: const Icon(Icons.verified_rounded));

                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => ExpenseConfirmSheet(
                                        docID: docId,
                                        desc: data['itemDescription']));
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
