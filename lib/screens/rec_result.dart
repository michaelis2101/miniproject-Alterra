import 'package:appk_flutter/models/openai_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.gptResponseData});

  final GptData gptResponseData;

  //  String resultRec = widget.gptResponseData.choices[0].message.content;
  @override
  Widget build(BuildContext context) {
    String resultRec = gptResponseData.choices[0].message.content;

    List<String> recList = resultRec.split('\n');

    print(resultRec);

    return Scaffold(
      backgroundColor: const Color(0xff26619C),
      appBar: AppBar(
        backgroundColor: const Color(0xff26619C),
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommendations:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: recList.map((rec) {
                      List<String> parts = rec.split(': ');

                      if (parts.length >= 2) {
                        String category = parts[0];
                        String money = parts[1];

                        // List<String> moneyPlan = money.split('. ');
                        // String currency = moneyPlan[0];
                        // String moneyPerCat = moneyPlan[1];

                        return ListTile(
                          title: Text(category),
                          subtitle: Text(money),
                        );
                      } else {
                        return ListTile(
                          title: const Text('Invalid format'),
                          subtitle: Container(),
                        );
                      }
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8, right: 8, bottom: 15),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Add Recommendation to Plan',
                      style: TextStyle(color: Color(0xff26619C)),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
