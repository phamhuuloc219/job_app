import 'dart:convert';

ProfileUpdateReq profileUpdateReqFromJson(String str) => ProfileUpdateReq.fromJson(json.decode(str));

String profileUpdateReqToJson(ProfileUpdateReq data) => json.encode(data.toJson());

class ProfileUpdateReq {
    final String username;
    final String location;
    final String phone;

    ProfileUpdateReq({
        required this.username,
        required this.location,
        required this.phone,
    });

    factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) => ProfileUpdateReq(
        username: json["username"],
        location: json["location"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "location": location,
        "phone": phone,
    };
}