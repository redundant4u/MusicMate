class Music {
  int? id, musicId;
  String? name, artist, url;

  Music({ this.id, this.name, this.artist, this.url, this.musicId });
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
      'musicId': musicId
    };
  }

  @override
  int get hashCode {
    return this.name.hashCode ^ this.artist.hashCode;
  }

  @override
  operator == (dynamic other) {
    if(!(other is Music))
      return false;
    return (this.name == other.name) && (this.artist == other.artist);
  } 
}