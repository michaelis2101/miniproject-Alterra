import 'package:flutter/material.dart';

class ListExpenses extends StatefulWidget {
  const ListExpenses({super.key});

  @override
  State<ListExpenses> createState() => _ListExpensesState();
}

class _ListExpensesState extends State<ListExpenses> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text('List Screen')],
    );
  }
}
