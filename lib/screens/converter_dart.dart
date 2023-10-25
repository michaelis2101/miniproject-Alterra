import 'package:appk_flutter/classes/complete_cur.dart';
import 'package:appk_flutter/classes/list_currency.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  TextEditingController inputCurCont = TextEditingController();

  // final List<String> currencyCodes = ['IDR', 'USD'];
  ListCurrencyCode listCurCode = ListCurrencyCode();
  CompleteCurrencies currenciesStrings = CompleteCurrencies();
  List<String> currencyCodes = [];
  List<String> currenciesComp = [];
  String result = '';

  String? selectedCurrency = 'IDR';
  String? toSelectedCurrency;

  String? resultFrom = '';
  String? resultTo = '';
  String? conversionRate = '';

  Future<void> fetchCurrency(String selectCur) async {
    try {
      final response = await Dio()
          .get(
              // "https://v6.exchangerate-api.com/v6/b6cb02bdd75844d509f88dac/pair/USD/IDR/20")
              "https://v6.exchangerate-api.com/v6/b6cb02bdd75844d509f88dac/pair/${selectedCurrency.toString()}/$selectCur/${inputCurCont.text.toString()}")
          .then((reposne) {
        print(reposne.statusCode);
        print(reposne.data);
        print(reposne.statusMessage);

        Map<String, dynamic> responseData = reposne.data;
        if (responseData.containsKey('conversion_result') &&
            responseData['conversion_result'] is double) {
          double conversionResult = responseData['conversion_result'];
          setState(() {
            result = '$selectCur. ${conversionResult.toString()}';
            resultFrom = responseData['base_code'].toString();
            resultTo = responseData['target_code'].toString();
            conversionRate = responseData['conversion_rate'].toString();
          });
        } else {
          setState(() {
            result = 'Conversion rate not available';
          });
        }

        print(result);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currencyCodes = listCurCode.currencyCodes;
      currenciesComp = currenciesStrings.currencyStrings;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputCurCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff26619C),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            // centerTitle: true,
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
              'Currency Exchange',
              style: TextStyle(color: Colors.white),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Currency',
                        style: TextStyle(color: Color(0xff26619C)),
                      ),
                      items: currencyCodes
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
                      value: selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          // selectedDescription = null;
                          selectedCurrency = value;
                        });
                        // print(selectedDescription);
                      },
                      buttonStyleData: ButtonStyleData(
                        width: MediaQuery.of(context).size.width *
                            0.3, //width items
                        height: 62,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          // border: Border.all(
                          //   color: Colors.black26,
                          // ),
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
                        // padding: EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width *
                            0.3, //width items
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
                    SizedBox(
                      // width: 258,
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width * 0.35,
                      child: TextField(
                        controller: inputCurCont,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIconColor: Color(0xff26619C),
                          labelStyle: TextStyle(color: Color(0xff26619C)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xff26619C)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusColor: Color(0xff26619C),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          hintText: 'Name of something you buy',
                          prefixIcon: Icon(Icons.local_grocery_store),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.swap_vert,
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Text(
                    'Currency',
                    style: TextStyle(color: Color(0xff26619C)),
                  ),
                  items: currenciesComp
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
                  value: toSelectedCurrency,
                  onChanged: (value) {
                    // List<String?> splitCur = value!.split('-');
                    // print(splitCur);
                    // String? codeCur = splitCur[0];
                    // String? descCur = splitCur[1];

                    setState(() {
                      toSelectedCurrency = value;
                    });

                    print(toSelectedCurrency);

                    // print(selectedDescription);
                  },
                  buttonStyleData: ButtonStyleData(
                    width: MediaQuery.of(context).size.width, //width items
                    height: 62,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      // border: Border.all(
                      //   color: Colors.black26,
                      // ),
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
                    // padding: EdgeInsets.only(left: 8.0),
                    width: MediaQuery.of(context).size.width, //width items
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
                  height: 10,
                ),
                // if (result.isNotEmpty)
                //   ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(10)),
                //     child: Container(
                //       width: MediaQuery.of(context).size.width,
                //       height: 50,
                //       decoration: const BoxDecoration(color: Colors.white),
                //       child: Text(
                //         result.toString(),
                //         style: const TextStyle(
                //             color: Color(0xff26619C), fontSize: 30),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                const SizedBox(
                  height: 10,
                ),
                if (result.isEmpty)
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          List<String> codeToSelectedCur =
                              toSelectedCurrency!.split('-');

                          String codeCur = codeToSelectedCur[0];
                          String descCur = codeToSelectedCur[1];

                          // print(codeCur);

                          fetchCurrency(codeCur);
                        },
                        child: const Text('Submit')),
                  ),
                if (result.isNotEmpty)
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          setState(() {
                            result = '';
                            inputCurCont.clear();
                          });
                        },
                        child: const Text('Reset')),
                  ),

                const SizedBox(
                  height: 10,
                ),

                if (result.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Your Conversion Result:',
                            style: TextStyle(
                                fontSize: 25, color: Color(0xff26619C)),
                          ),
                          Text(
                            'From $resultFrom to $resultTo',
                            style: const TextStyle(color: Color(0xff26619C)),
                          ),
                          // Text(),
                          Text(
                            result.toString(),
                            style: const TextStyle(
                                color: Color(0xff26619C), fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          // Text('From $resultFrom to $resultTo', style: const TextStyle(color: Color(0xff26619C)),),
                          Text(
                            'Conversion Rate : $conversionRate',
                            style: const TextStyle(color: Color(0xff26619C)),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
