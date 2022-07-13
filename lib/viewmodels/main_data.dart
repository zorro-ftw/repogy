import 'package:flutter/foundation.dart';
import 'package:repogy/services/repo_services.dart';
import '../models/repo.dart';
import '../models/user.dart';

class MainData extends ChangeNotifier {
  late Repo currentRepo;
  late User currentRepoOwner;
  final RepoService _repoService = RepoService();

  Future getFullData(String url) async {}

  String parseGivenUrl(String url) {
    List<String> split = url.split('github.com');
    return 'asd';
  }
}
