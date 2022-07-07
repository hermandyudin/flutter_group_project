class Artist {
  final int id;
  final String name;
  final String imageUrl;

  const Artist(this.id, this.name, this.imageUrl);

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      json['id'] as int,
      json['name'] as String,
      json['image_url'] as String
    );
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    return other is Artist && id == other.id;
  }
}