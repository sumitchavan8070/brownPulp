import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.response,
    this.user,
  });

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    response = json['response'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  num? status;
  String? response;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['response'] = response;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.token,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    token = json['token'];
  }

  num? id;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['phoneNumber'] = phoneNumber;
    map['token'] = token;
    return map;
  }
}
