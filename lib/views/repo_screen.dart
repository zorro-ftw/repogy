import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/enums.dart';
import 'package:repogy/viewmodels/main_data.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Provider.of<MainData>(context).dataMode == DataMode.loading){
      return const Center(child: SizedBox(
        height: 30,
          width: 30,
          child: CircularProgressIndicator(),),);
    }else{
      return Container(color: Colors.red,);
    }
  }
}

