import 'package:repogy/models/user.dart';

class Repo {
  Repo(
      {required this.name,
      required this.owner,
      required this.private,
      required this.pullRequests,
      this.lastPushDate,
      this.description});
  String name;
  String? description;
  User? owner;
  bool private;
  int pullRequests;
  DateTime? lastPushDate;

}
