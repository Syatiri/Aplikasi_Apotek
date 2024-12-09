class User {
  final String userId;
  final String username;
  final String password;
  final String role; // e.g., Admin, Kasir, Manager, etc.

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.role,
  });

  // Optional: Convert user to map (useful for serialization)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'password': password,
      'role': role,
    };
  }

  // Optional: Create a user from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      username: map['username'],
      password: map['password'],
      role: map['role'],
    );
  }
}
