import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/constants.dart';
import 'package:repogy/enums.dart';
import 'package:repogy/viewmodels/main_data.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Provider.of<MainData>(context).dataMode == DataMode.loading){
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(title: const Text("Loading"),
        backgroundColor: kPrimaryColorDark,),
        body: const Center(child: SizedBox(
          height: 30,
            width: 30,
            child: CircularProgressIndicator(),),),
      );
    }else if(Provider.of<MainData>(context).dataMode == DataMode.success) {
      return Scaffold(
        appBar: AppBar(title: Text(Provider
            .of<MainData>(context)
            .currentRepo
            ?.name??""),
          backgroundColor: kPrimaryColorDark,),
        body: Container(
          color: kPrimaryColor,
        ),
      );
    }else{
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(title: const Text("Error"),
          backgroundColor: kPrimaryColorDark,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("We had trouble fetching data from the server.",
            style: TextStyle(
              color: kGeneralTextColor,
              fontSize: 16
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Text("Please check and verify owner/repo name or try again later.",
            style: TextStyle(
              color: kGeneralTextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 80,)
          ],
        ),
      );
    }
  }
}

