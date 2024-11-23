import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {

  @HiveField(0)
  String id;
  @HiveField(1)
  String username;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password
  });

  @override
  String toString() {
    return 'id: $id , username:$username , email:$email , password:$password';
  }

  Map<String,dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password
    };
  }

  factory User.fromJson(Map<String,dynamic> json) {
      return User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );
  }

}