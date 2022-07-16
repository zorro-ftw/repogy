import 'package:flutter/material.dart';
import 'package:repogy/constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.iconData, required this.title})
      : super(key: key);

  final IconData iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10,
      dense: true,
      leading: Icon(
        iconData,
        color: kPrimaryColorDark,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
