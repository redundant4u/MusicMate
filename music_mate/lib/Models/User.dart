class User {
  int? id;
  String? name, nickName, password, token, key;

  User({ this.id, this.name, this.nickName, this.password, this.token, this.key });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nickName': nickName,
      'password': password,
      'token': token,
      'key': key
    };
  }
}