class FavoriteModel {
  final String id;
  final String songId;
  final String userId;
  FavoriteModel({required this.id, required this.songId, required this.userId});

  FavoriteModel copyWith({String? id, String? songId, String? userId}) {
    return FavoriteModel(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'song_id': songId, 'user_id': userId};
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      songId: map['song_id'] as String,
      userId: map['user_id'] as String,
    );
  }
}
