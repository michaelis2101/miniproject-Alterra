// import 'package:appk_flutter/main.dart';
// import 'package:appk_flutter/screens/login_handler.dart';
import 'package:appk_flutter/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool hidePw = false;
  Color lapisLazuli = const Color(0xff26619C);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hidePw = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCont.dispose();
    passwordCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xff26619C)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: ClipRRect(
                  key: const Key('appLogo'),
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/images/appklogo.png')),
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
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: logIn,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff26619C),
                                // minimumSize: const Size.fromHeight(50),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => const SignUpScreen(),
                      transition: Transition.rightToLeft);
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Future logIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCont.text.trim(),
        password: passwordCont.text.trim(),
      );
      // Get.offAll(() => const LoggedInHandler());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      // Get.snackbar('Error', e.message.toString(),
      //     backgroundColor: Colors.white, icon: const Icon(Icons.error));

      // Get.snackbar('Error', e.message ?? 'An error occurred',
      //     backgroundColor: Colors.white, icon: const Icon(Icons.error));
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        // Get.snackbar('Error', 'Invalid email or password',
        //     backgroundColor: Colors.white, icon: const Icon(Icons.error));
        Fluttertoast.showToast(
            msg: "invalid email or password",
            backgroundColor: Colors.white,
            textColor: lapisLazuli);
      } else if (e.code == 'too-many-requests') {
        Fluttertoast.showToast(
            msg: "Stop Spamming Login Idiot",
            backgroundColor: Colors.white,
            textColor: lapisLazuli);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "Email Format Invalid",
            backgroundColor: Colors.white,
            textColor: lapisLazuli);
      } else if (e.code == 'user-disabled') {
        Fluttertoast.showToast(
            msg: "User Disabled, Contact Feveloper For Information",
            backgroundColor: Colors.white,
            textColor: lapisLazuli);
      }

      // print(e);
    }

    // Navigator.of(context).pop();
    Get.back();

    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
