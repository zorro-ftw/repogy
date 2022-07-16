import 'package:flutter/foundation.dart';
import 'package:repogy/services/repo_services.dart';
import '../models/repo.dart';
import '../models/user.dart';
import 'package:repogy/enums.dart';

/// This class will be storing all necessary data to use with state management.
class MainData extends ChangeNotifier {
  Repo? currentRepo; // Variable to store current repo information
  User? currentRepoOwner;  // Variable to store current repo owner information
  int? pullRequests;   // Variable to store current repo pull request numbers.
  dynamic ownerRawData; // Variable to store raw data for User request
  dynamic repoRawData; // Variable to store raw data for Repo request
  DataMode dataMode =
      DataMode.loading; // Setting dataMode to loading as default
  final RepoService _repoService = RepoService();
  final String apiLinkRepo = "https://api.github.com/repos/";
  late String composedRepoApi;

  /// Initiates the data collecting operation. Created to be called from MainScreen.
  Future getFullData(String url) async {
    dataMode = DataMode.loading;
    notifyListeners();

    // Composing the final version for api request.
    composedRepoApi = apiLinkRepo + parseGivenUrl(url);

    // If url cannot be parsed, "dataMode" will be updated as fail in "parseGivenUrl" function.
    // That's why, the control step below is required.
    if(dataMode != DataMode.fail){
      repoRawData = await _repoService.getRepoData(composedRepoApi);  // Requesting repo data.
    }

    // If data request was not successful "dataMode" will be updated as fail and process will be stopped.
    if (repoRawData.runtimeType == bool && !repoRawData || dataMode == DataMode.fail) {
      dataMode = DataMode.fail;
      notifyListeners();
    } else {
      // If we succeed getting data for the repo, we can continue with other data.
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
        description: repoRawData["description"],
        lastPushDate: DateTime.parse(repoRawData["pushed_at"])
      );
      dataMode = DataMode.success;  // Process is completed. "dataMode" can be marked as success now.
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
    List<String>? split = url.split('github.com/');
    if(split.length == 1 || split == null){
      dataMode = DataMode.fail;
      notifyListeners();
      return split[0];
    }
    // Adding a control step for a corner case i.e. "/" at the end
    if (split[1][split[1].length - 1] == "/") {
      split[1] = split[1].substring(0, split[1].length - 1);
    }

    return split[1];
  }
}

//
//
