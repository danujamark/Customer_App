import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_contact/model/contac_model.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatefulWidget {
  final ContactModel contactModel;
  const AboutPage({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
              child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2022/06/15/17/14/little-girl-7264330_960_720.jpg",
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.contactModel.name,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                widget.contactModel.job,
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
              Row(
                children: [
                  SvgPicture.asset(
                    'asstes/images/dot.svg',
                    color: Colors.red,
                    height: 7.0,
                    width: 7.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    "  Introduce ${widget.contactModel.name} To Partner",
                    style: TextStyle(fontSize: 23),
                  ),
                ],
              ),
              Column(children: [
                Text(
                  widget.contactModel.description,
                  style: TextStyle(fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 40, 20, 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              widget.contactModel.phone,
                            ),
                            //Description(context: context, controllerName: _description),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              widget.contactModel.homeNumber,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              widget.contactModel.email,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              widget.contactModel.socialId,
                            )
                          ],
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Contact ${widget.contactModel.name}'),
                ),
              ])
            ],
          ))
        ],
      ),
    ));
  }
}
