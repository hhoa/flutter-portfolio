// To parse this JSON data, do
//
//     final experienceModel = experienceModelFromJson(jsonString);

import 'dart:convert';

List<ExperienceModel> experienceModelFromJson(String str) =>
    List<ExperienceModel>.from(
        json.decode(str).map((x) => ExperienceModel.fromJson(x)));

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
}
