// To parse this JSON data, do
//
//     final experienceModel = experienceModelFromJson(jsonString);

import 'dart:convert';

List<ExperienceModel> experienceModelFromJson(String str) =>
    List<ExperienceModel>.from(
        json.decode(str).map((x) => ExperienceModel.fromJson(x)));

String experienceModelToJson(List<ExperienceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExperienceModel {
  ExperienceModel({
    required this.company,
    this.logo,
    this.description,
    this.time,
  });

  final String company;
  final String? description;
  final String? time;
  final String? logo;

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      ExperienceModel(
        company: json["company"],
        description: json["description"],
        time: json["time"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "description": description,
        "time": time,
        "logo": logo,
      };
}
