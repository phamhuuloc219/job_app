import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
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
    final CompanyId companyId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final CategoryId categoryId;

    GetJobRes({
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
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.categoryId,
    });

    factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
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
        companyId: CompanyId.fromJson(json["companyId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryId: CategoryId.fromJson(json["categoryId"]),
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
        "companyId": companyId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "categoryId": categoryId.toJson(),
    };
}

class CategoryId {
    final String id;
    final String title;

    CategoryId({
        required this.id,
        required this.title,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
    };
}

class CompanyId {
    final String id;
    final String userId;
    final String company;

    CompanyId({
        required this.id,
        required this.userId,
        required this.company,
    });

    factory CompanyId.fromJson(Map<String, dynamic> json) => CompanyId(
        id: json["_id"],
        userId: json["userId"],
        company: json["company"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "company": company,
    };
}
