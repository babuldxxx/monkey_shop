class User {
  final int id;
  final String name;
  final String login;
  final String password;
  String role;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    this.role = 'user',
  });

  bool get isAdmin => role == 'admin';

  factory User.newUser({
    required String name,
    required String login,
    required String password,
    String role = 'user',
  }) {
    return User(
      id: 0,
      name: name,
      login: login,
      password: password,
      role: role,
    );
  }
}

// List<User> users = [];
