import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

//nama, tgl, bulan, tahun, jenis, total

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController dateController = TextEditingController();

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
  String? selectedPrimary;

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
  String? selectedSecondary;

  final List<String> classifiedItems = [
    'Primary',
    'Secondary',
  ];
  String? selectedClassifiedValue;

  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();

  // Future<DateTime?> selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       dateController.text = DateFormat('yyyy-MM-dd').format(picked);
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedClassifiedValue =
    //     classifiedItems.isNotEmpty ? classifiedItems[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    String date = selectedDate.day.toString();
    String month = selectedDate.month.toString();
    String year = selectedDate.year.toString();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Add Expenses",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white),
            ),
          ),
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
                    value: selectedPrimary,
                    onChanged: (value) {
                      setState(() {
                        selectedPrimary = value;
                        selectedSecondary = null;
                      });
                      print(selectedPrimary);
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
                    value: selectedSecondary,
                    onChanged: (value) {
                      setState(() {
                        selectedSecondary = value;
                        selectedPrimary = null;
                      });
                      print(selectedSecondary);
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDatePicker2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date'),
            Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
          ],
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
                  lastDate: DateTime(now.year + 100));

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
