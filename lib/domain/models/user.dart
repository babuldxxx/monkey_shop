class User {
  final int? id;
  final String name;
  final String login;
  final String password;
  final String role;

  User({
    this.id,
    required this.name,
    required this.login,
    required this.password,
    this.role = 'user',
  });
}

List<User> users = [];
