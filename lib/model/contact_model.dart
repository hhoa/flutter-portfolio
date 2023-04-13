// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

List<ContactModel> contactModelFromJson(String str) => List<ContactModel>.from(
    json.decode(str).map((dynamic x) => ContactModel.fromJson(x)));

String contactModelToJson(List<ContactModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModel {
  ContactModel({
    required this.icon,
    required this.link,
  });

  final String? icon;
  final String? link;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        icon: json["icon"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "link": link,
      };

  bool get isNull => icon == null || link == null;
}
