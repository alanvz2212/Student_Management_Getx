import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:student_management_getx/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      home: Splash(),
    );
  }
}
