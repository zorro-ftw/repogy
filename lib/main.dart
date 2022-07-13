import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/viewmodels/main_data.dart';
import 'package:repogy/views/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => MainData(),
      child: const Repogy(),
    ),
  );
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
