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
    dynamic key,
    required this.isUpdate,
    this.createdAt,
    this.name,
    this.avatar,
    this.phone,
    this.streetAddress,
    this.city,
    this.zip,
    this.country,
    this.job,
    this.email,
    this.description,
    this.homeNumber,
    this.socialId,
    this.id,
  });

  DateTime? createdAt;
  String? name;
  String? avatar;
  String? phone;
  String? streetAddress;
  String? city;
  String? zip;
  String? country;
  String? job;
  String? email;
  String? description;
  String? homeNumber;
  String? socialId;
  String? id;
  String? position;
  String? location;
  bool? isUpdate;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
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
        isUpdate: null,
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
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

  compareTo(ContactModel item1) {}
}

class ErrorModel {
  bool isError;
  int statusCode;
  String errorMessage;

  ErrorModel(
      {required this.statusCode, this.isError = false, this.errorMessage = ''});
}
