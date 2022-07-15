import 'package:flutter/foundation.dart';
import 'package:repogy/services/repo_services.dart';
import '../models/repo.dart';
import '../models/user.dart';
import 'package:repogy/enums.dart';

/// This class will be storing all necessary data to use with state management.
class MainData extends ChangeNotifier {
  late Repo currentRepo; // Variable to store current repo information
  late User currentRepoOwner;
  int? pullRequests; // Variable to store current repo owner information
  late dynamic ownerRawData; // Variable to store raw data for User request
  late dynamic repoRawData; // Variable to store raw data for Repo request
  DataMode dataMode =
      DataMode.loading; // Setting dataMode to loading as default
  final RepoService _repoService = RepoService();
  final String apiLinkRepo = "https://api.github.com/repos/";
  late String composedRepoApi;

  /// Initiates the data collecting operation. Created to be called from MainScreen.
  Future getFullData(String url) async {
    dataMode = DataMode.loading;
    notifyListeners();

    composedRepoApi = apiLinkRepo + parseGivenUrl(url);
    repoRawData = await _repoService.getRepoData(composedRepoApi);
    if (repoRawData.runtimeType == bool && !repoRawData) {
      dataMode = DataMode.fail;
      notifyListeners();
    } else {
      await getOwnerData();
      await getPullRequests();
    }

    // If all data collecting is completed successfully, continue building related variables.
    if (dataMode != DataMode.fail) {
      currentRepo = Repo(
        name: repoRawData["name"],
        owner: currentRepoOwner,
        private: repoRawData["private"],
        pullRequests: pullRequests ?? 0,
      );
      dataMode = DataMode.success;
      notifyListeners();
    }
  }

  /// Requests data of owner User.
  Future getOwnerData() async {
    ownerRawData =
        await _repoService.getUserData(repoRawData["owner"]["login"]);
    if (ownerRawData.runtimeType == bool && !ownerRawData) {
      dataMode = DataMode.fail;
      notifyListeners();
    } else {
      currentRepoOwner =
          await _repoService.getUserData(repoRawData["owner"]["login"]);
    }
  }

  /// Requests data for pull request numbers of current repo.
  Future getPullRequests() async {
    pullRequests = await _repoService.getPullRequests(composedRepoApi);
    if (pullRequests == null) {
      dataMode = DataMode.fail;
    }
    notifyListeners();
  }

  /// Parses URL given by user to obtain repository's and owner's name.
  String parseGivenUrl(String url) {
    // Splits the given string into two parts, we need the second part, meaning "/{owner}/{repo}"
    List<String> split = url.split('github.com/');
    print("SPLIT GELDİ = $split");

    // Adding a control step for a corner case i.e. "/" at the end
    if (split[1][split[1].length - 1] == "/") {
      split[1] = split[1].substring(0, split[1].length - 1);
    }

    return split[1];
  }
}

//
//
