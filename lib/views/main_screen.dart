import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/viewmodels/main_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MainData>(context, listen: false)
        .getFullData("https://github.com/zorro-ftw/publist/");

    return const Center(
      child: Text('Hello World'),
    );
  }
}
