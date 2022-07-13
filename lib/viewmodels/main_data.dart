import 'package:flutter/foundation.dart';
import 'package:repogy/services/repo_services.dart';
import '../models/repo.dart';
import '../models/user.dart';

/// This class will be storing all necessary data to use with state management.
class MainData extends ChangeNotifier {
  late Repo currentRepo;  // Variable to store current repo information
  late User currentRepoOwner;  // Variable to store current repo owner information
  late dynamic rawData;  // Variable to store raw data
  final RepoService _repoService = RepoService();
  final String apiLinkRepo = "https://api.github.com/repos/";

  Future getFullData(String url) async {
    final String composedRepoApi = apiLinkRepo + parseGivenUrl(url);
    rawData = await _repoService.getRepoData(composedRepoApi);

    if(rawData.runtimeType == bool && !rawData){
      print("RAWDATA FALSE ÇIKTI");
    }
    //currentRepo = Repo(name: rawData[0]['name'], owner: owner, private: private, pullRequests: pullRequests, collaborators: collaborators)
    if (kDebugMode) {
      print(rawData);
    }
  }

  /// Parses URL given by user to obtain repository's and owner's name.
  String parseGivenUrl(String url) {

    // Splits the given string into two parts, we need to second part, meaning "/{owner}/{repo}"
    List<String> split = url.split('github.com/');

    // Adding a control step for a corner case i.e. "/" at the end
    if(split[1][split[1].length-1] == "/" ){
      split[1] = split[1].substring(0, split[1].length-1);
    }

    return split[1];
  }
}
