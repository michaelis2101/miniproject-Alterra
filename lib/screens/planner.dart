import 'package:appk_flutter/screens/rec_result.dart';
import 'package:appk_flutter/services/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Planner extends StatefulWidget {
  const Planner({super.key});

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  TextEditingController incomeCont = TextEditingController();
  TextEditingController daysCont = TextEditingController();
  TextEditingController savingsCont = TextEditingController();
  TextEditingController debtCont = TextEditingController();
  TextEditingController debtPayCont = TextEditingController();
  TextEditingController goalCont = TextEditingController();
  TextEditingController goalPriceCont = TextEditingController();
  bool _isLoading = false;

  void getRecommendation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await RecService.getRec(
          income: incomeCont.text,
          // days: daysCont.text.isEmpty ? '30' : daysCont.text,
          savings: savingsCont.text.isEmpty ? '0' : savingsCont.text,
          debt: debtCont.text.isEmpty ? '0' : debtCont.text,
          monthlyDebtPayment: debtCont.text.isEmpty ? '0' : debtPayCont.text,
          goal: goalCont.text.isEmpty ? 'nothing' : goalCont.text,
          goalPrice: goalPriceCont.text.isEmpty ? '0' : goalPriceCont.text);

      if (mounted) {
        Get.to(() => ResultPage(gptResponseData: result));
        print(result);
        setState(() {
          _isLoading = false;
        });

        incomeCont.clear();
        daysCont.clear();
        savingsCont.clear();
        debtCont.clear();
        debtPayCont.clear();
        goalCont.clear();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.white, icon: const Icon(Icons.error));
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    incomeCont.dispose();
    daysCont.dispose();
    savingsCont.dispose();
    debtCont.dispose();
    debtPayCont.dispose();
    goalCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Get Finance Management Recommendation",
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white),
            textAlign: TextAlign.center,
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
                        'Income',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: incomeCont,
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
                      hintText: 'Enter your monthly income',
                      prefixIcon: Icon(Icons.monetization_on),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Align(
                  //     alignment: Alignment.bottomLeft,
                  //     child: Text(
                  //       'For how Many Days',
                  //       style: TextStyle(color: Colors.white, fontSize: 20),
                  //     )),
                  // TextField(
                  //   controller: daysCont,
                  //   decoration: const InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     prefixIconColor: Color(0xff26619C),
                  //     labelStyle: TextStyle(color: Color(0xff26619C)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(width: 1.0, color: Color(0xff26619C)),
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //     focusColor: Color(0xff26619C),
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide(width: 1.0),
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //     hintText: 'Enter your monthly income',
                  //     prefixIcon: Icon(Icons.calendar_today_rounded),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Savings',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: savingsCont,
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
                      hintText: 'Enter your Savings',
                      prefixIcon: Icon(Icons.money_sharp),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Debt',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: debtCont,
                    onChanged: (value) {
                      setState(() {
                        debtCont.text = value;
                      });
                      print(debtCont.text);
                    },
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
                      hintText:
                          'leave blank or fill with 0 if you dont have debt',
                      // prefixIcon: Icon(Icons.mone),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (debtCont.text.isNotEmpty)
                    const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Debt Payment/Month',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  if (debtCont.text.isNotEmpty)
                    TextField(
                      controller: debtPayCont,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText:
                            'leave blank or fill with 0 if you dont have debt',
                        // prefixIcon: Icon(Icons.mone),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Goal/Wish',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  TextField(
                    controller: goalCont,
                    onChanged: (value) {
                      setState(() {
                        goalCont.text = value;
                      });
                    },
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
                      hintText:
                          'leave blank or fill with 0 if you dont have debt',
                      // prefixIcon: Icon(Icons.mone),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (goalCont.text.isNotEmpty)
                    const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Goal/Wish Price',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  if (goalCont.text.isNotEmpty)
                    TextField(
                      controller: goalPriceCont,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter your monthly income',
                        // prefixIcon: Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: _isLoading
                        ? const Center(
                            child: LinearProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              if (incomeCont.text.isEmpty) {
                                Get.snackbar("Error",
                                    'Please Insert at Least Your Income',
                                    backgroundColor: Colors.white,
                                    icon: const Icon(
                                        Icons.warning_amber_rounded));
                              } else {
                                getRecommendation();
                              }
                            },
                            child: const Text(
                              'Get Recommendation',
                              style: TextStyle(color: Color(0xff26619C)),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
