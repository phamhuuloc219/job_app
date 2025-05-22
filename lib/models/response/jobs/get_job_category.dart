import 'dart:convert';

GetJobCategoryRes getJobCategoryResFromJson(String str) => GetJobCategoryRes.fromJson(json.decode(str));

String getJobCategoryResToJson(GetJobCategoryRes data) => json.encode(data.toJson());

class GetJobCategoryRes {
  final String id;
  final String title;
  final String description;
  final int v;

  GetJobCategoryRes({
    required this.id,
    required this.title,
    required this.description,
    required this.v,
  });

  factory GetJobCategoryRes.fromJson(Map<String, dynamic> json) => GetJobCategoryRes(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "__v": v,
  };
}