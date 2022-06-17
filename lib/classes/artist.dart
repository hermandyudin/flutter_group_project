class Artist {
  final int id;
  final String name;
  final String imageUrl;

  const Artist(this.id, this.name, this.imageUrl);

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      json['id'],
      json['name'],
      json['image_url']
    );
  }
}