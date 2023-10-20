import 'package:appk_flutter/controller/update_controller.dart';
import 'package:appk_flutter/models/expense_model.dart';
import 'package:appk_flutter/models/user_model.dart';
import 'package:appk_flutter/viewmodels/expense_vm.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateExpenses extends StatefulWidget {
  const UpdateExpenses({super.key});

  @override
  State<UpdateExpenses> createState() => _UpdateExpensesState();
}

class _UpdateExpensesState extends State<UpdateExpenses> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final UserController userC = Get.put(UserController());

  final List<String> primaryItems = [
    'Food',
    'Shelter',
    'Clothing',
    'Healthcare',
    'Education',
    'Transportation',
    'Utilities',
    'Personal hygiene and toiletries',
    'Basic household supplies',
    'Taxes and insurance',
    'Savings and emergency fund',
    'Debt repayment',
  ];
  String? selectedDescription;

  final List<String> secondaryItems = [
    'Entertainment',
    'Travel and vacations',
    'Hobbies and interests',
    'Electronics and gadgets',
    'Home decor and furnishings',
    'Clothing and accessories',
    'Dining out and socializing',
    'Fitness and wellness',
    'Non-essential subscriptions',
    'Gifts and special occasions',
    'Luxury items and indulgences',
    'Charitable contributions',
  ];
  // String? selectedDescription;

  final List<String> classifiedItems = [
    'Primary',
    'Secondary',
  ];
  String? selectedClassifiedValue;

  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  void initState() {
    final selectedExpense = expenseController.selectedExpense.value;
    // TODO: implement initState
    super.initState();
    nameCont.text = selectedExpense.itemDescription.toString();
    priceCont.text = selectedExpense.itemPrice.toString();
    selectedClassifiedValue = selectedExpense.expensesCategory.toString();
    selectedDescription = selectedExpense.categoryDescription.toString();
    print(selectedExpense.id.toString());

    try {
      int day = int.parse(selectedExpense.date);
      int month = int.parse(selectedExpense.month);
      int year = int.parse(selectedExpense.year);

      selectedDate = DateTime(year, month, day);
    } catch (e) {
      // Handle parsing error
      print("Error parsing date: $e");
    }

    // selectedDate =
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCont.dispose();
    priceCont.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedExpense = expenseController.selectedExpense.value;
    String date = selectedDate.day.toString();
    String month = selectedDate.month.toString();
    String year = selectedDate.year.toString();

    // String selectedDDate = selectedExpense.date.toString();
    // String selectedMonth = selectedExpense.month.toString();
    // String selectedYear = selectedExpense.year.toString();

    String currentUserId = userC.uid.value;
    final expenseViewModel = ExpenseViewModel(currentUserId);
    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xff26619C),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Update Expenses',
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 40,
            // ),
            // const Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "Add Expenses",
            //     style: TextStyle(
            //         fontSize: 25,
            //         color: Colors.white,
            //         decoration: TextDecoration.underline,
            //         decorationColor: Colors.white),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Item Description',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: nameCont,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: Color(0xff26619C),
                      labelStyle: TextStyle(color: Color(0xff26619C)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Color(0xff26619C)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusColor: Color(0xff26619C),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Name of something you buy',
                      prefixIcon: Icon(Icons.local_grocery_store),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Expenses Category',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Select Item',
                      style: TextStyle(color: Color(0xff26619C)),
                    ),
                    items: classifiedItems
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff26619C),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedClassifiedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedClassifiedValue = value;
                      });
                      print(selectedClassifiedValue);
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Color(0xff26619C),
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(10),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (selectedClassifiedValue == 'Primary')
                    DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Item',
                        style: TextStyle(color: Color(0xff26619C)),
                      ),
                      items: primaryItems
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff26619C),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedDescription,
                      onChanged: (value) {
                        setState(() {
                          selectedDescription = value;
                        });
                        print(selectedDescription);
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Color(0xff26619C),
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(10),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  if (selectedClassifiedValue == 'Primary')
                    const SizedBox(
                      height: 10,
                    ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  if (selectedClassifiedValue == 'Secondary')
                    DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Item',
                        style: TextStyle(color: Color(0xff26619C)),
                      ),
                      items: secondaryItems
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff26619C),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedDescription,
                      onChanged: (value) {
                        setState(() {
                          selectedDescription = value;
                          // selectedPrimary = null;
                        });
                        print(selectedDescription);
                        // print(date);
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Color(0xff26619C),
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(10),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  if (selectedClassifiedValue == 'Secondary')
                    const SizedBox(
                      height: 10,
                    ),
                  buildDatePicker2(context),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Item Price',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: priceCont,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIconColor: Color(0xff26619C),
                      labelStyle: TextStyle(color: Color(0xff26619C)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Color(0xff26619C)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusColor: Color(0xff26619C),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'IDR',
                      prefixIcon: Icon(Icons.price_change),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          Expense addNewEx = Expense(
                              id: selectedExpense.id.toString(),
                              userId: selectedExpense.userId.toString(),
                              itemDescription: nameCont.text,
                              expensesCategory:
                                  selectedClassifiedValue.toString(),
                              categoryDescription:
                                  selectedDescription.toString(),
                              date: date,
                              year: year,
                              month: month,
                              itemPrice: int.parse(priceCont.text));

                          await expenseViewModel.updateExpense(addNewEx);
                          Get.back();
                          Get.snackbar('Succes', 'Item Updated',
                              backgroundColor: Colors.white,
                              icon: const Icon(Icons.verified));
                          setState(() {
                            nameCont.clear();
                            priceCont.clear();
                            date = now.day.toString();
                            year = now.year.toString();
                            month = now.month.toString();
                          });
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Color(0xff26619C)),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(color: Color(0xff26619C), fontSize: 18),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(selectedDate),
                    style: const TextStyle(color: Color(0xff26619C)),
                  ),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(color: Color(0xff26619C)),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              final selectDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(1890),
                lastDate: DateTime(now.year + 100),
              );

              setState(() {
                if (selectDate != null) {
                  selectedDate = selectDate;

                  print(selectedDate.day);
                  print(selectedDate.month);
                  print(selectedDate.year);
                }
              });
            },
            child: const Text(
              'Select',
              style: TextStyle(color: Color(0xff26619C)),
            ))
      ],
    );
  }
}
