import 'package:appk_flutter/screens/login_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController repeatPwCont = TextEditingController();

  bool hidePw = false;
  bool reHidePw = false;

  bool isValidEmail(String email) {
    // Define a regular expression for email validation
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hidePw = true;
    reHidePw = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCont.dispose();
    passwordCont.dispose();
    repeatPwCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff26619C),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios))
        // ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xff26619C)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                            controller: emailCont,
                            onChanged: (value) {},
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
                              labelText: 'Email',
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(Icons.email_rounded),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: passwordCont,
                          obscureText: hidePw,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor: const Color(0xff26619C),
                              labelStyle:
                                  const TextStyle(color: Color(0xff26619C)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color(0xff26619C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusColor: const Color(0xff26619C),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                              prefixIcon: const Icon(Icons.password_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePw = !hidePw;
                                  });
                                },
                                icon: Icon(hidePw
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: repeatPwCont,
                          obscureText: reHidePw,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor: const Color(0xff26619C),
                              labelStyle:
                                  const TextStyle(color: Color(0xff26619C)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color(0xff26619C)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusColor: const Color(0xff26619C),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Repeat Password',
                              hintText: 'Repeat Your Password',
                              prefixIcon: const Icon(Icons.password_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    reHidePw = !reHidePw;
                                  });
                                },
                                icon: Icon(reHidePw
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final validEmail = emailCont.text;

                              if (emailCont.text.isEmpty ||
                                  passwordCont.text.isEmpty ||
                                  repeatPwCont.text.isEmpty) {
                                Get.snackbar(
                                    'Error', 'Please fill all the TextField',
                                    backgroundColor: Colors.white,
                                    icon: const Icon(Icons.warning));
                              } else {
                                if (!isValidEmail(validEmail)) {
                                  Get.snackbar('Error', 'Email not Valid',
                                      backgroundColor: Colors.white,
                                      icon: const Icon(Icons.warning));
                                } else {
                                  if (passwordCont.text.length < 8 ||
                                      repeatPwCont.text.length < 8) {
                                    Get.snackbar('Error',
                                        'Password at least 8 characters',
                                        backgroundColor: Colors.white,
                                        icon: const Icon(Icons.warning));
                                  } else if (passwordCont.text !=
                                      repeatPwCont.text) {
                                    Get.snackbar('Error', 'Password not Match',
                                        backgroundColor: Colors.white,
                                        icon: const Icon(Icons.warning));
                                  } else {
                                    signUp();
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff26619C),
                                // minimumSize: const Size.fromHeight(50),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCont.text,
        password: repeatPwCont.text,
      );

      // Get.to(LoggedInHandler());

      // The success should be shown here, and the circular progress indicator should be dismissed
      FirebaseAuth.instance.signOut();
      Get.snackbar('Success', 'Account Created, Please Login',
          backgroundColor: Colors.white, icon: const Icon(Icons.check));
      Get.back();
    } on FirebaseAuthException catch (e) {
      // Error snackbar should be shown for Firebase exceptions
      Get.snackbar('Error', e.message.toString(),
          backgroundColor: Colors.white, icon: const Icon(Icons.error));
    }

    Get.back();
  }
}
