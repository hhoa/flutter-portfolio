// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

List<ProjectModel> projectModelFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

String projectModelToJson(List<ProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectModel {
  ProjectModel({
    required this.image,
    required this.description,
    required this.link,
  });

  final String image;
  final String description;
  final String link;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        image: json["image"],
        description: json["description"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "description": description,
        "link": link,
      };
}
