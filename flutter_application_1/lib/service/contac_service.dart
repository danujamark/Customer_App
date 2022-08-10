import 'dart:convert';
import 'package:http/http.dart';
import '../model/contact_model.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart' as http;

class ContactService {
  static const url = "https://629dce7c3dda090f3c0b91c0.mockapi.io/api/contacts";
  var client = https.Client;
  static Future<ContactListModel> fechcontact() async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ContactListModel.fromJson(
          json,
        );
      } else {
        return ContactListModel(
            contactList: [],
            errorModel:
                ErrorModel(statusCode: response.statusCode, errorMessage: ''));
      }
    } catch (e) {
      return ContactListModel(
          contactList: [],
          errorModel: ErrorModel(statusCode: 400, errorMessage: e.toString()));
    }
  }

  createContact(
      {required String name,
      required String position,
      required String city,
      required String description,
      required String phone,
      required String homeNumber,
      required String email,
      required String socialId}) {}

  updateContact(
      {required String name,
      required String position,
      required String city,
      required String description,
      required String phone,
      required String homeNumber,
      required String email,
      required String socialId,
      required String id}) {}
}

Future<int> createContact(
    {required String name,
    required String position,
    required String city,
    required String description,
    required String phone,
    required String homeNumber,
    required String email,
    required String socialId}) async {
  final response = await http.post(
    Uri.parse('https://629dce7c3dda090f3c0b91c0.mockapi.io/api/contacts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'job': position,
      'city': city,
      'description': description,
      'phone': phone,
      'home_number': homeNumber,
      'email': email,
      'social_id': socialId
    }),
  );
  return response.statusCode;
  // if (response.statusCode == 201) {
  //   return ContactModel.fromJson(jsonDecode(response.body));
  // } else {
  //   throw Exception('Failed to create contact');
  // }
}

Future<int> updateContact({
  required String name,
  required String position,
  required String city,
  required String description,
  required String phone,
  required String homeNumber,
  required String email,
  required String socialId,
  required String id,
}) async {
  final response = await http.put(
    Uri.parse('https://629dce7c3dda090f3c0b91c0.mockapi.io/api/contacts/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'job': position,
      'city': city,
      'description': description,
      'phone': phone,
      'home_number': homeNumber,
      'email': email,
      'social_id': socialId,
      'id': id,
    }),
  );
  return response.statusCode;
  // if (response.statusCode == 200) {
  //   return ContactModel.fromJson(jsonDecode(response.body));
  // } else {
  //   throw Exception('Failed to update contact');
  // }
}
