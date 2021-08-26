import './Music.dart';

class Friend {
  String? name, nickName;

  Friend({ this.name, this.nickName });
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nickName': nickName,
    };
  }
}