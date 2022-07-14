import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repogy/models/user.dart';

class RepoService {
  /// Returns the raw decoded data for the given url.
  /// Returns false if response status code is anything other than 200.
  Future getRepoData(String url) async {
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      return false;
    }
  }

  /// Returns the number of pull requests for current repo.
  /// Returns "null" if response status code is anything other than 200.
  Future getPullRequests(String url) async {
    String modifiedURL = "$url/pulls";
    Uri uri = Uri.parse(modifiedURL);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData.length;
    } else {
      return null;
    }
  }


  /// Returns User object for given username.
  /// Returns false if response status code is anything other than 200.
  Future getUserData(String username) async {
    Uri uri = Uri.parse("https://api.github.com/users/$username");

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return User(userName: decodedData["login"], createdAt: DateTime.parse(decodedData["created_at"]), avatarURL: decodedData["avatar_url"], publicRepos: decodedData["public_repos"], followers: decodedData["followers"]);
    } else {
      return false;
    }
  }

}
