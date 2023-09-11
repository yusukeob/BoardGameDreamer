class User {
  final int id;
  final String username;
  final String password;

  const User({
    required this.id,
    required this.username,
    required this.password,
  });

  static final columns = ["id", "username", "password"];

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
      id: data['id'],
      username: data['username'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password}';
  }
}
