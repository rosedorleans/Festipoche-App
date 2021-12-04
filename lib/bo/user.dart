class User {
  final String id;
  final String email;
  final String roles;
  final String password;
  final String festivalPass;

  User({
    required this.id,
    required this.email,
    required this.roles,
    required this.password,
    required this.festivalPass
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        roles: json['roles'],
        password: json['password'],
        festivalPass: json['festivalPass'],
    );
  }
}