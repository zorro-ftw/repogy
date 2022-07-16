import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repogy/constants.dart';
import 'package:repogy/enums.dart';
import 'package:repogy/viewmodels/main_data.dart';

import '../viewmodels/properties_list.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MainData>(context).dataMode == DataMode.loading) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text("Loading"),
          backgroundColor: kPrimaryColorDark,
        ),
        body: const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: kAccentColor,
            ),
          ),
        ),
      );
    } else if (Provider.of<MainData>(context).dataMode == DataMode.success) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Provider.of<MainData>(context).currentRepo?.name ?? "",
            style: const TextStyle(
              fontSize: 24,
              color: kAccentColor,
            ),
          ),
          backgroundColor: kPrimaryColorDark,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: kPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          Provider.of<MainData>(context)
                              .currentRepoOwner!
                              .avatarURL),
                      radius: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${Provider.of<MainData>(context).currentRepoOwner?.userName}",
                          style: const TextStyle(
                              color: kGeneralTextColor, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${Provider.of<MainData>(context).currentRepoOwner?.publicRepos} public repositories",
                          style: const TextStyle(
                              color: kGeneralTextColor, fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              color: kPrimaryColorLight,
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                          ),
                        ),
                        Text(
                          "${Provider.of<MainData>(context).currentRepoOwner?.followers} followers",
                          style: const TextStyle(
                              color: kGeneralTextColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: kPrimaryColorLight,
                child: const PropertiesList(),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text("Error"),
          backgroundColor: kPrimaryColorDark,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "We had trouble fetching data from the server.",
              style: TextStyle(color: kGeneralTextColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please check and verify owner/repo name or try again later.",
              style: TextStyle(
                color: kGeneralTextColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      );
    }
  }
}
