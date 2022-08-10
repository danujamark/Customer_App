// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ContactListModel {
  late List<ContactModel> contactList;

  ErrorModel errorModel;

  ContactListModel({required this.contactList, required this.errorModel});

  factory ContactListModel.fromJson(json) => ContactListModel(
      contactList:
          List<ContactModel>.from(json.map((x) => ContactModel.fromJson(x))),
      errorModel: ErrorModel(statusCode: 200, isError: false));
}

class ContactModel {
  ContactModel({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.phone,
    required this.streetAddress,
    required this.city,
    required this.zip,
    required this.country,
    required this.job,
    required this.email,
    required this.description,
    required this.homeNumber,
    required this.socialId,
    required this.id,
  });

  DateTime createdAt;
  String name;
  String avatar;
  String phone;
  String streetAddress;
  String city;
  String zip;
  String country;
  String job;
  String email;
  String description;
  String homeNumber;
  String socialId;
  String id;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        phone: json["phone"],
        streetAddress: json["street_address"],
        city: json["city"],
        zip: json["zip"],
        country: json["country"],
        job: json["job"],
        email: json["email"],
        description: json["description"],
        homeNumber: json["home_number"],
        socialId: json["social_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "phone": phone,
        "street_address": streetAddress,
        "city": city,
        "zip": zip,
        "country": country,
        "job": job,
        "email": email,
        "description": description,
        "home_number": homeNumber,
        "social_id": socialId,
        "id": id,
      };
}

class ErrorModel {
  bool isError;
  int statusCode;
  String errorMessage;

  ErrorModel(
      {required this.statusCode, this.isError = false, this.errorMessage = ''});
}
