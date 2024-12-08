import 'package:auth_project/pages/home.dart';
import 'package:auth_project/pages/login.dart';
import 'package:auth_project/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_project/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Project',
      theme: ThemeData(
        fontFamily: "Rubik",
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: Login()
    );
  }
}
