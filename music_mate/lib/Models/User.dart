class User {
  int? id;
  String? name, nick_name, password;

  User({ this.id, this.name, this.nick_name, this.password });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nick_name': nick_name,
      'password': password,
    };
  }
}