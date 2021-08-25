class Music {
  int? id;
  String? name, artist, url;

  Music({ this.id, this.name, this.artist, this.url });
  Music.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.url = json['preview_url'];
    this.artist = json['artists'][0]['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'url': url,
    };
  }
}