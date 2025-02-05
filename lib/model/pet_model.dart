// To parse this JSON data, do
//
//     final petDetailsList = petDetailsListFromJson(jsonString);

import 'dart:convert';

List<PetDetailsList> petDetailsListFromJson(String str) => List<PetDetailsList>.from(json.decode(str).map((x) => PetDetailsList.fromJson(x)));

String petDetailsListToJson(List<PetDetailsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetDetailsList {
    int? id;
    String? userName;
    String? petName;
    String? petType;
    String? gender;
    String? location;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? imageUrl;

    PetDetailsList({
        this.id,
        this.userName,
        this.petName,
        this.petType,
        this.gender,
        this.location,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
    });

    factory PetDetailsList.fromJson(Map<String, dynamic> json) => PetDetailsList(
        id: json["id"],
        userName: json["user_name"],
        petName: json["pet_name"],
        petType: json["pet_type"],
        gender: json["gender"],
        location: json["location"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "pet_name": petName,
        "pet_type": petType,
        "gender": gender,
        "location": location,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
    };
}
