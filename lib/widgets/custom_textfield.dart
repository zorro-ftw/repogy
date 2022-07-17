import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/constants.dart';

import '../viewmodels/main_data.dart';
import '../views/repo_screen.dart';

/// Custom created TextField
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      style: const TextStyle(color: kPrimaryColorLight),
      decoration: InputDecoration(
          hintText: "https://github.com/user/repo",
          hintStyle: TextStyle(
            color: kPrimaryColorLight.withOpacity(0.5),
          ),
          labelText: "Github Repository URL",
          labelStyle: TextStyle(
            color: kPrimaryColorLight.withOpacity(0.7),
          ),
          floatingLabelStyle: const TextStyle(color: kAccentColor),
          suffixIcon: _textEditingController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () => _textEditingController.clear(),
                  icon: const Icon(Icons.close),
                  color: kPrimaryColorLight,
                ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kAccentColor, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kAccentColor, width: 2),
          )),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) async {
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
    );
  }

  /// Shows a toast (snackbar) message. Created for the first URL control.
  void showToast(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: kPrimaryColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
