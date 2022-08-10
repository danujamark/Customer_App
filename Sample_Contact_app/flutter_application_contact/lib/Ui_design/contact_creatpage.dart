import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

import '../model/contac_model.dart';
import '../service/contact_service.dart';

import 'contact_homepage.dart';

class CreationWidget extends StatefulWidget {
  bool? isUpdate = false;
  String? createdAt;
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
  String? position;
  String? location;
  int? id;

  @override
  State<CreationWidget> createState() => _CreationWidgetState();
}

class _CreationWidgetState extends State<CreationWidget> {
  final TextEditingController name = TextEditingController();
  // var txt = TextEditingController();
  final TextEditingController position = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController homeNumber = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final TextEditingController socialId = TextEditingController();
  Future<ContactModel>? futureContact;

  @override
  void initState() {
    widget.isUpdate == true ? name.text = widget.name ?? "" : name.text = "";
    widget.isUpdate == true
        ? position.text = widget.position ?? ""
        : position.text = "";
    widget.isUpdate == true
        ? location.text = widget.location ?? ""
        : location.text = "";
    widget.isUpdate == true
        ? description.text = widget.description ?? ""
        : description.text = "";
    widget.isUpdate == true ? phone.text = widget.phone ?? "" : phone.text = "";
    widget.isUpdate == true
        ? homeNumber.text = widget.homeNumber ?? ""
        : homeNumber.text = "";
    widget.isUpdate == true ? mail.text = widget.email ?? "" : mail.text = "";
    widget.isUpdate == true
        ? socialId.text = widget.socialId ?? ""
        : socialId.text = "";
    super.initState();
  }

  Widget buildolumn() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.blue,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              singleLineTextField(
                  context: context, lblText1: "Name", controllerName: name),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel_outlined, color: Colors.grey),
              )
            ],
          ),
          singleLineTextField(
              context: context, lblText1: "Position", controllerName: position),
          singleLineTextField(
              context: context, lblText1: "Location", controllerName: location),
          editDescription(context: context, controllerName: description),
          allCardArea(
              context: context,
              controllerName1: [phone, homeNumber, mail, socialId]),
          buttonComponent(context: context),
        ],
      ),
    );
  }

  FutureBuilder<ContactModel> buildFutureBuilder() {
    return FutureBuilder<ContactModel>(
      future: futureContact,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Navigator.pop(
            context,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget singleLineTextField(
      {required BuildContext context,
      required String lblText1,
      required controllerName}) {
    return TextField(
      controller: controllerName,
      maxLines: 1,
      style: const TextStyle(
        fontFamily: 'Schyler',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        labelText: lblText1,
        labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget editDescription(
      {required BuildContext context, required controllerName}) {
    return Expanded(
      child: Container(
        height: 142,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SizedBox(
              height: 14,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Intoduce Alex to partner",
                    style: TextStyle(
                      //fontFamily: 'Schyler',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            TextField(
              controller: controllerName,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: 'Schyler',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: Color.fromARGB(255, 176, 168, 168),
              ),
              decoration: const InputDecoration(
                // labelText: "Hello",

                hintMaxLines: 4,
                hintText:
                    "I've met Alex at an event in Monterrey. He is one of the most influential businessman in the region. I would like to introduce him to my trade partner i EI Pase.",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 185, 177, 177),
                ),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonComponent({required BuildContext context}) {
    return InkWell(
      onTap: () async {
        if (widget.isUpdate == false) {
          if (name.text == "" ||
              position.text == "" ||
              location.text == "" ||
              description.text == "" ||
              phone.text == "" ||
              homeNumber.text == "" ||
              mail.text == "" ||
              socialId.text == "") {
            alertBoxF(
                context: context,
                mainText: "Failed!",
                subText: "Data cannot be empty!");
          } else {
            int sttdcode1 = await ContactService().createContact(
                name: name.text,
                position: position.text,
                city: location.text,
                description: description.text,
                phone: phone.text,
                homeNumber: homeNumber.text,
                email: mail.text,
                socialId: socialId.text);

            if (sttdcode1 == 201) {
              alertBoxS(
                  context: context,
                  mainText: "Success",
                  subText: "New Contact Added ");
            } else {
              alertBoxF(
                  context: context,
                  mainText: "Failed",
                  subText: "Failed To Add New Contact");
            }
          }
        } else if (widget.isUpdate == true) {
          if (name.text == "" ||
              position.text == "" ||
              location.text == "" ||
              description.text == "" ||
              phone.text == "" ||
              homeNumber.text == "" ||
              mail.text == "" ||
              socialId.text == "") {
            alertBoxF(
                context: context,
                mainText: "Update Failed!",
                subText: "Data cannot be empty!");
          } else {
            int sttCode = await ContactService().updateContact(
              name: name.text,
              position: position.text,
              city: location.text,
              description: description.text,
              phone: phone.text,
              homeNumber: homeNumber.text,
              email: mail.text,
              socialId: socialId.text,
              id: widget.id.toString(),
            );
            if (sttCode == 200) {
              alertBoxS(
                  context: context,
                  mainText: "Successful",
                  subText: "Contact Details Updated");
            } else {
              alertBoxF(
                  context: context,
                  mainText: "Failed",
                  subText: "update Failed!");
            }
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 2,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Text(
          widget.isUpdate == false ? "Save Contact" : "Save Contact",
          style: const TextStyle(
            fontFamily: 'Schyler',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: Color.fromARGB(200, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  Widget allCardArea(
      {required BuildContext context, required controllerName1}) {
    return SizedBox(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          individualCard(
            context: context,
            icon: Icons.phone,
            hintForInput: "+52 55 1234 5678",
            controllerName: controllerName1[0],
          ),
          individualCard(
            context: context,
            icon: Icons.home,
            hintForInput: "+1 (555) 555-1234",
            controllerName: controllerName1[1],
          ),
          individualCard(
            context: context,
            icon: Icons.mail,
            hintForInput: "alexsmith@gmail.com",
            controllerName: controllerName1[2],
          ),
          individualCard(
            context: context,
            icon: Icons.camera,
            hintForInput: "@alexmonterrey",
            controllerName: controllerName1[3],
          ),
        ],
      ),
    );
  }

  Widget individualCard(
      {required BuildContext context,
      required IconData icon,
      required String hintForInput,
      required TextEditingController controllerName}) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 59, 125, 231),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
          ),
          Container(
            width: 250,
            margin: const EdgeInsets.only(left: 25),
            child: TextField(
              controller: controllerName,
              style: const TextStyle(
                fontFamily: 'Schyler',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: hintForInput,
                hintStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                labelStyle: const TextStyle(
                    color: Color.fromARGB(127, 255, 255, 255),
                    fontWeight: FontWeight.w200),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(158, 243, 243, 243),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 243, 243, 243),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future alertBoxS(
      {required BuildContext context,
      required String mainText,
      required subText}) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Center(
                child: Text(
                  mainText,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              content: SizedBox(
                height: 24,
                width: 400,
                child: Center(
                  child: Text(
                    subText,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeWidget()));
                        // setState(() {});
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                )
              ],
            ));
  }

  Future alertBoxF(
      {required BuildContext context,
      required String mainText,
      required subText}) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Center(
                child: Text(
                  mainText,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              content: SizedBox(
                height: 24,
                width: 400,
                child: Center(
                  child: Text(
                    subText,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage()));
                      },
                      child: const Text("Ok"),
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildolumn(),
    );
  }
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
}
