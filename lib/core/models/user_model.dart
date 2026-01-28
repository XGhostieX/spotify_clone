class UserModel {
  final String id;
  final String token;
  final String name;
  final String email;

  UserModel({required this.id, required this.token, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  UserModel copyWith({String? name, String? email, String? id, String? token}) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
