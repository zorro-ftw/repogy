import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/viewmodels/main_data.dart';
import 'package:repogy/widgets/custom_list_tile.dart';

class PropertiesList extends StatelessWidget {
  const PropertiesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => buildProperties(context, index),
    );
  }

  Widget buildProperties(BuildContext context, int index) {
    switch (index) {
      case 0:
        {
          return CustomListTile(
              iconData: Icons.arrow_forward_ios_rounded,
              title: Provider.of<MainData>(context).currentRepo?.name ?? "");
        }
      case 1:
        {
          return CustomListTile(
              iconData: Icons.arrow_forward_ios_rounded,
              title: Provider.of<MainData>(context).currentRepo?.description ??
                  "No description is provided");
        }
      case 2:
        {
          return CustomListTile(
              iconData: Icons.arrow_forward_ios_rounded,
              title:
                  "${Provider.of<MainData>(context).currentRepo?.pullRequests} pull requests");
        }
      case 3:
        {
          return CustomListTile(
              iconData: Icons.arrow_forward_ios_rounded,
              title:
              Provider.of<MainData>(context).currentRepo?.private?? false ?"Private": "Public");
        }
      case 4:
        {

          return CustomListTile(
              iconData: Icons.arrow_forward_ios_rounded,
              title:Provider.of<MainData>(context)
                  .currentRepo
                  ?.lastPushDate
                  .toString().substring(0,10) == null ?
                  "": "Last updated at ${Provider.of<MainData>(context)
                  .currentRepo
                  ?.lastPushDate
                  .toString().substring(0,10)}");
        }
      default:
        {
          return Container();
        }
    }
  }
}
