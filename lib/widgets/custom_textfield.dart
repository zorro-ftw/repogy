import 'package:flutter/material.dart';
import 'package:repogy/constants.dart';

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
                  icon: const Icon(Icons.close), color: kPrimaryColorLight,),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColorLight, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kAccentColor, width: 2),
          )),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.search,
    );
  }
}
