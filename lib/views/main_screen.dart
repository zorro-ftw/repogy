import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/constants.dart';
import 'package:repogy/viewmodels/main_data.dart';
import 'package:repogy/views/repo_screen.dart';

import '../widgets/custom_textfield.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColorDark,
        elevation: 1,
        title: const Text("Repogy"),
        titleTextStyle: const TextStyle(fontSize: 24, color: kGeneralTextColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kPrimaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.85,
                        child: const Text(
                          "Enter Github repository link and get all the essential info right away.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, color: kPrimaryColorLight),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        child: CustomTextField(
                            textEditingController: _textEditingController),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: size.width * 0.7,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: kAccentColor,
                        fixedSize: Size(size.width * 0.55, 30)),
                    icon: const Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                    label: const Text(
                      "Search",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    onPressed: () async {
                      // Handling the case where button is clicked with wrong inputs.
                      if (!_textEditingController.text.contains("github.com")) {
                        showToast(context,
                            "Seems like URL does not meet requirements. Please check spelling and try again.");
                      } else {
                        Provider.of<MainData>(context, listen: false)
                            .getFullData(_textEditingController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RepoScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a toast (snackbar) message. Created for the first URL control.
  void showToast(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: kPrimaryColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        content: Text(message, textAlign: TextAlign.center,),
      ),
    );
  }
}
