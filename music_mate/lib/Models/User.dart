class User {
  int? id;
  String? name, nickName, password;

  User({ this.id, this.name, this.nickName, this.password });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nickName': nickName,
      'password': password,
    };
  }
}