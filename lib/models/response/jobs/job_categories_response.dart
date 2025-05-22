import 'dart:convert';

List<JobCategoriesResponse> jobCategoriesResponseFromJson(String str) => List<JobCategoriesResponse>.from(json.decode(str).map((x) => JobCategoriesResponse.fromJson(x)));

String jobCategoriesResponseToJson(List<JobCategoriesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobCategoriesResponse {
  final String id;
  final String title;
  final String description;
  final int v;

  JobCategoriesResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.v,
  });

  factory JobCategoriesResponse.fromJson(Map<String, dynamic> json) => JobCategoriesResponse(
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
