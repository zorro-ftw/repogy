import 'package:flutter/foundation.dart';
import 'package:repogy/services/repo_services.dart';
import '../models/repo.dart';
import '../models/user.dart';

/// This class will be storing all necessary data to use with state management.
class MainData extends ChangeNotifier {
  late Repo currentRepo; // Variable to store current repo information
  late User
      currentRepoOwner; // Variable to store current repo owner information
  late dynamic rawData; // Variable to store raw data
  final RepoService _repoService = RepoService();
  final String apiLinkRepo = "https://api.github.com/repos/";

  Future getFullData(String url) async {
    final String composedRepoApi = apiLinkRepo + parseGivenUrl(url);
    rawData = await _repoService.getRepoData(composedRepoApi);
    final rawData2 = await _repoService.getUserData("zorro-ftw");
    if (rawData2.runtimeType == bool && !rawData2) {
      //TODO RETURN ERROR MESSAGE
    }
    //currentRepoOwner = User(userName: rawData[0]['owner'][0]['login'], createdAt: createdAt, avatarURL: avatarURL, publicRepos: publicRepos, followers: followers, currentRepoContributions: currentRepoContributions)
    //currentRepo = Repo(name: rawData[0]['name'], owner: , private: private, pullRequests: pullRequests, collaborators: collaborators)
  }

  /// Parses URL given by user to obtain repository's and owner's name.
  String parseGivenUrl(String url) {
    // Splits the given string into two parts, we need the second part, meaning "/{owner}/{repo}"
    List<String> split = url.split('github.com/');

    // Adding a control step for a corner case i.e. "/" at the end
    if (split[1][split[1].length - 1] == "/") {
      split[1] = split[1].substring(0, split[1].length - 1);
    }

    return split[1];
  }
}
