import 'dart:convert';

List<JobsResponse> jobsResponseFromJson(String str) => List<JobsResponse>.from(json.decode(str).map((x) => JobsResponse.fromJson(x)));

String jobsResponseToJson(List<JobsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsResponse {
    final String id;
    final String title;
    final String location;
    final String description;
    final String companyName;
    final String salary;
    final String period;
    final String contract;
    final bool hiring;
    final List<String> requirement;
    final String imageUrl;
    final int v;
    final String companyId;
    final String categoryId;

    JobsResponse({
        required this.id,
        required this.title,
        required this.location,
        required this.description,
        required this.companyName,
        required this.salary,
        required this.period,
        required this.contract,
        required this.hiring,
        required this.requirement,
        required this.imageUrl,
        required this.companyId,
        required this.v,
        required this.categoryId,
    });

    factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        companyName: json["companyName"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        hiring: json["hiring"],
        requirement: List<String>.from(json["requirement"].map((x) => x)),
        imageUrl: json["imageUrl"],
        companyId: json["companyId"],
        v: json["__v"],
        categoryId: json["categoryId"] is Map<String, dynamic> ? json["categoryId"]["_id"] : json["categoryId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "description": description,
        "companyName": companyName,
        "salary": salary,
        "period": period,
        "contract": contract,
        "hiring": hiring,
        "requirement": List<dynamic>.from(requirement.map((x) => x)),
        "imageUrl": imageUrl,
        "companyId": companyId,
        "__v": v,
        "categoryId": categoryId,
    };
}
