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

  Future getUserData(String username) async {
    Uri uri = Uri.parse("https://api.github.com/users/$username");

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      //DateTime createdAt = DateTime(decodedData[0]["created_at"].substring());
      return decodedData;
    } else {
      return false;
    }
  }
}
