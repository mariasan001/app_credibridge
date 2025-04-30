class LoginPayload {
  final String username;
  final String password;

  LoginPayload({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class Role {
  final int id;
  final String description;

  Role({
    required this.id,
    required this.description,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      description: json['description'],
    );
  }
}

class User {
  final String userId;
  final String name;
  final String email;
  final List<Role> roles;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.roles,
  });

factory User.fromJson(Map<String, dynamic> json) {
  final rolesData = json['roles'];

  List<Role> parsedRoles = [];

  if (rolesData is List) {
    parsedRoles = rolesData.map((role) => Role.fromJson(role)).toList();
  } else if (rolesData is Map) {
    parsedRoles = rolesData.values.map((role) => Role.fromJson(role)).toList();
  }

  return User(
    userId: json['userId'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    roles: parsedRoles,
  );
}

}

class LoginResponse {
  final String token;
  final User user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
