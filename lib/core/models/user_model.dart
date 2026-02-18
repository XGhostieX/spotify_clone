import 'favorite_model.dart';

class UserModel {
  final String id;
  final String token;
  final String name;
  final String email;
  final List<FavoriteModel> favorites;

  UserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.favorites,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      token: map['token'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      favorites: List<FavoriteModel>.from(
        (map['favorites'] ?? []).map((favorite) => FavoriteModel.fromMap(favorite)),
      ),
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? id,
    String? token,
    List<FavoriteModel>? favorites,
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      favorites: favorites ?? this.favorites,
    );
  }
}
