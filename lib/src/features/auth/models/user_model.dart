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

// -----------------------
// MODELO PRINCIPAL: USER
// -----------------------
class User {
  final String userId;
  final String name;
  final String? email;
  final String? rfc;
  final String? curp;
  final String? occupationDate;
  final String? phone;
  final WorkUnit? workUnit;
  final JobCode? jobCode;
  final PositionStatus? positionStatus;
  final Bank? bank;
  final UserStatus? userStatus; 
  final List<Role> roles;

  User({
    required this.userId,
    required this.name,
    this.email,
    this.rfc,
    this.curp,
    this.occupationDate,
    this.phone,
    this.workUnit,
    this.jobCode,
    this.positionStatus,
    this.bank,
    this.userStatus, 
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
      email: json['email'],
      rfc: json['rfc'],
      curp: json['curp'],
      occupationDate: json['occupationDate'],
      phone: json['phone'],
      workUnit: json['workUnit'] != null ? WorkUnit.fromJson(json['workUnit']) : null,
      jobCode: json['jobCode'] != null ? JobCode.fromJson(json['jobCode']) : null,
      positionStatus: json['positionStatus'] != null
          ? PositionStatus.fromJson(json['positionStatus'])
          : null,
      bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null,
      userStatus: json['userStatus'] != null ? UserStatus.fromJson(json['userStatus']) : null, // ✅
      roles: parsedRoles,
    );
  }
}

// -----------------------
// SUBMODELOS
// -----------------------

class Role {
  final int id;
  final String description;

  Role({required this.id, required this.description});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'],
        description: json['description'],
      );
}

class WorkUnit {
  final String id;
  final String desc;

  WorkUnit({required this.id, required this.desc});

  factory WorkUnit.fromJson(Map<String, dynamic> json) => WorkUnit(
        id: json['id'],
        desc: json['desc'],
      );
}

class Bank {
  final int id;
  final String desc;

  Bank({required this.id, required this.desc});

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json['id'],
        desc: json['desc'],
      );
}

class JobCode {
  final String id;
  final String desc;

  JobCode({required this.id, required this.desc});

  factory JobCode.fromJson(Map<String, dynamic> json) => JobCode(
        id: json['id'],
        desc: json['desc'],
      );
}

class PositionStatus {
  final int id;
  final String desc;

  PositionStatus({required this.id, required this.desc});

  factory PositionStatus.fromJson(Map<String, dynamic> json) => PositionStatus(
        id: json['id'],
        desc: json['desc'],
      );
}

class UserStatus {
  final int id;
  final String desc;

  UserStatus({required this.id, required this.desc});

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        id: json['id'],
        desc: json['desc'],
      );
}
