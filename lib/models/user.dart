/// This is the class to create Users
class User {
  User(
      {required this.userName,
      required this.createdAt,
      required this.avatarURL,
      required this.publicRepos,
      required this.followers,
       });
  String userName, avatarURL;
  int publicRepos, followers ;
  DateTime createdAt;
}
