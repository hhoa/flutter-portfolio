// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<ProjectModel> projectModelFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

class ProjectModel extends Equatable {
  const ProjectModel({
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

  @override
  List<Object?> get props => [
        image,
        description,
        link,
      ];
}
