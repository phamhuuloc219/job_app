import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
    GetJobRes({
        required this.id,
        required this.title,
        required this.location,
        required this.description,
        required this.agentName,
        required this.salary,
        required this.period,
        required this.contract,
        required this.hiring,
        required this.requirement,
        required this.imageUrl,
        required this.agentId,
        required this.v,
    });

    final String id;
    final String title;
    final String location;
    final String description;
    final String agentName;
    final String salary;
    final String period;
    final String contract;
    final bool hiring;
    final List<String> requirement;
    final String imageUrl;
    final String agentId;
    final int v;

    factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        agentName: json["agentName"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        hiring: json["hiring"],
        requirement: List<String>.from(json["requirement"].map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "description": description,
        "agentName": agentName,
        "salary": salary,
        "period": period,
        "contract": contract,
        "hiring": hiring,
        "requirement": List<dynamic>.from(requirement.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
        "__v": v,
    };
}
