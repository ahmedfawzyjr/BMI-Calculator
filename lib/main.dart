import 'package:bmi_calculator/Screens/inputPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(
          0xFF0A0E21,
        ),
        scaffoldBackgroundColor: const Color(
          0xFF0A0E21,
        ),
      ),
      home: const InputPage(),
    );
  }
}
