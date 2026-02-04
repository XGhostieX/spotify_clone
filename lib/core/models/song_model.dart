class SongModel {
  final String id;
  final String name;
  final String artist;
  final String thumbnail;
  final String song;
  final String color;
  SongModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.thumbnail,
    required this.song,
    required this.color,
  });

  SongModel copyWith({
    String? id,
    String? name,
    String? artist,
    String? thumbnail,
    String? song,
    String? color,
  }) {
    return SongModel(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      thumbnail: thumbnail ?? this.thumbnail,
      song: song ?? this.song,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'artist': artist,
      'thumbnail': thumbnail,
      'song': song,
      'color': color,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      artist: map['artist'] as String,
      thumbnail: map['thumbnail'] ?? '',
      song: map['song'] ?? '',
      color: map['color'] ?? '',
    );
  }
}
