import 'package:academic_schedule/screens/drawing_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Academic Schedule",
        home: HomeScreen()
    );
  }
}

