import 'dart:convert';

List<AllBookMarks> allBookMarksFromJson(String str) => List<AllBookMarks>.from(json.decode(str).map((x) => AllBookMarks.fromJson(x)));

String allBookMarksToJson(List<AllBookMarks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookMarks {
  final String id;
  final Job job;
  final String userId;
  final int v;

  AllBookMarks({
    required this.id,
    required this.job,
    required this.userId,
    required this.v,
  });

  factory AllBookMarks.fromJson(Map<String, dynamic> json) => AllBookMarks(
    id: json["_id"],
    job: Job.fromJson(json["job"]),
    userId: json["userId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "job": job.toJson(),
    "userId": userId,
    "__v": v,
  };
}

class Job {
  final String id;
  final String title;
  final String location;
  final String companyName;
  final String salary;
  final String period;
  final String contract;
  final bool hiring;
  final List<String> requirement;
  final String imageUrl;
  final String companyId;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.companyName,
    required this.salary,
    required this.period,
    required this.contract,
    required this.hiring,
    required this.requirement,
    required this.imageUrl,
    required this.companyId,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["_id"],
    title: json["title"],
    location: json["location"],
    companyName: json["companyName"],
    salary: json["salary"],
    period: json["period"],
    contract: json["contract"],
    hiring: json["hiring"],
    requirement: List<String>.from(json["requirement"].map((x) => x)),
    imageUrl: json["imageUrl"],
    companyId: json["companyId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "location": location,
    "companyName": companyName,
    "salary": salary,
    "period": period,
    "contract": contract,
    "hiring": hiring,
    "requirement": List<dynamic>.from(requirement.map((x) => x)),
    "imageUrl": imageUrl,
    "companyId": companyId,
  };
}