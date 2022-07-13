class User {
  User(
      {required this.userName,
      required this.createdAt,
      required this.avatarURL,
      required this.publicRepos,
      required this.followers,
      required this.currentRepoContributions});
  String userName, avatarURL;
  int publicRepos, followers, currentRepoContributions;
  DateTime createdAt;
}
