class Music {
  int? id;
  String? name, artist, url;

  Music({ this.id, this.name, this.artist, this.url });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'url': url,
    };
  }
}