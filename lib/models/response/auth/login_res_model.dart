import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String id;
    final String username;
    final String uid;
    final String profile;
    final String userToken;

    LoginResponseModel({
        required this.id,
        required this.username,
        required this.uid,
        required this.profile,
        required this.userToken,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        id: json["_id"],
        username: json["username"],
        uid: json["uid"],
        profile: json["profile"],
        userToken: json["userToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "uid": uid,
        "profile": profile,
        "userToken": userToken,
    };
}