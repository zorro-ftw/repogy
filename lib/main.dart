import 'package:flutter/material.dart';
import 'package:repogy/views/main_screen.dart';

void main() {
  runApp(const Repogy());
}

class Repogy extends StatelessWidget {
  const Repogy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
