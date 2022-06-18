class Song {
  final int id;
  final int ownerId;
  final String title;
  final String artistNames;
  final String imageUrl;
  final String url;

  const Song(this.id, this.ownerId, this.title, this.artistNames, this.imageUrl, this.url);

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        json['id'],
        json['lyrics_owner_id'],
        json['title'],
        json['artist_names'],
        json['header_image_url'],
        json['url']
    );
  }
}