import 'dart:convert';

UpdateProfileRes updateProfileResFromJson(String str) => UpdateProfileRes.fromJson(json.decode(str));

String updateProfileResToJson(UpdateProfileRes data) => json.encode(data.toJson());

class UpdateProfileRes {
  final String id;
  final String username;
  final String email;
  final String uid;
  final bool updated;
  final bool isAdmin;
  final bool isCompany;
  final bool skills;
  final String profile;
  final String location;
  final String phone;

  UpdateProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.uid,
    required this.updated,
    required this.isAdmin,
    required this.isCompany,
    required this.skills,
    required this.profile,
    required this.location,
    required this.phone,
  });

  factory UpdateProfileRes.fromJson(Map<String, dynamic> json) => UpdateProfileRes(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    uid: json["uid"],
    updated: json["updated"],
    isAdmin: json["isAdmin"],
    isCompany: json["isCompany"],
    skills: json["skills"],
    profile: json["profile"],
    location: json["location"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "uid": uid,
    "updated": updated,
    "isAdmin": isAdmin,
    "isCompany": isCompany,
    "skills": skills,
    "profile": profile,
    "location": location,
    "phone": phone,
  };
}