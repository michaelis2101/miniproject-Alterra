import 'dart:io';

import 'package:appk_flutter/screens/login_screen.dart';
import 'package:appk_flutter/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import
import 'package:get/get.dart';

void main() {
  testWidgets('Test Login Screen button', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  // testWidgets('App logo', (WidgetTester test) async {
  //   await test.pumpWidget(const MaterialApp(
  //     home: LoginScreen(),
  //   ));

  //   // expect(find.image(FileImage(File('assets/images/appklogo.png'))),
  //   //     findsOneWidget);
  //   expect(
  //       find.widgetWithImage(
  //           ClipRRect, FileImage(File('assets/images/appklogo.png'))),
  //       findsOneWidget);
  // });

  testWidgets('App logo', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.byKey(const Key('appLogo')), findsOneWidget);
  });

  testWidgets('TextFields', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('TextField email', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
  });

  testWidgets('TextField password', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
  });

  testWidgets('TextField password', (WidgetTester test) async {
    await test.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextButton, 'SignUp'), findsOneWidget);
  });
}
