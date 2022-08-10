import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../../model/contact_model.dart';

class AboutWidget extends StatefulWidget {
  final ContactModel contactModel;
  AboutWidget({required this.contactModel});

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  final TextEditingController name = TextEditingController();

  final TextEditingController position = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController homeNumber = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final TextEditingController socialId = TextEditingController();
  String btnText = "Submit";
  bool isUpdate = false;
  String imageUrl =
      "https://cdn.pixabay.com/photo/2016/11/29/13/56/asian-1870022_960_720.jpg";

  //  var obj = {
  //   "name": name.text,
  //   "avatar":
  //       "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/154.jpg",
  //   "age": position.text
  // };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cancel),
          Center(
              child: Expanded(
            child: Expanded(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        imageUrl,
                        width: 90.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.contactModel.name ?? '',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.contactModel.description ?? '',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  // Column(
                  //   children: [
                  //      singleLineTextField(
                  //   context: context, lblText1: "Name", controllerName: _name),
                  //   ],
                  // )
                  const Divider(
                    height: 50,
                    thickness: 2,
                    color: Color.fromARGB(255, 218, 211, 211),
                  ),
                  const Text(
                    " • Introduce Alex To Partner",
                    style: TextStyle(fontSize: 23),
                  ),
                  Column(children: [
                    const Text(
                      " i've met Alex at an event in Monterrey,He is \n one of the most influentiol businessman in the \n region,i would like to interduce him to my \n trade partner in EI paso.",
                      style: TextStyle(fontSize: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 40, 20, 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("+52 55 1234 5678"),
                                //Description(context: context, controllerName: _description),
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.home,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("+52 55 1234 5678")
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.mail,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("+52 55 1234 5678")
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.camera,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("+52 55 1234 5678")
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Contact'),
                    ),
                  ])
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
