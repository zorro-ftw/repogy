import 'package:http/http.dart' as http;
import 'dart:convert';

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
}
