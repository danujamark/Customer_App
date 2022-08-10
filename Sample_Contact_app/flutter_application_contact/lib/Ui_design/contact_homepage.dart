

import 'dart:ffi';
import 'dart:ui';
import '../model/contac_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../service/contact_service.dart';
import 'contact_creatpage.dart';
import 'contact_viewpage.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ContactListModel contactListModel = new ContactListModel(
      contactList: [], errorModel: new ErrorModel(statusCode: 200));

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ContactService.fechcontact().then((value) {
      contactListModel = value;

      if (!contactListModel.errorModel.isError) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  removeItem(int index) {
    setState(() {
      contactListModel.contactList.removeAt(index);
    });
  }

  sort() {
    setState(() {
      contactListModel.contactList.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  recent() {
    setState(() {
      contactListModel.contactList
          .sort((a, b) => a.createdAt.compareTo(b.createdAt));
    });
  }

  Key alphKey = const Key('alpha');
  Key recentKey = const Key('recent');
  late Key selectedKey;
  @override
  Widget build(BuildContext context) {
    // selectedKey == alphKey
    //? sortList(contactModel: contactDetails)
    //: sortListDate(contactModel: contactDetails);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 10, 5),
        child: Container(
          child: Column(children: [
            welcomeText(),
            textfeld(),
            buttoncard(sort, recent),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : buildList(contactListModel, removeItem),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreationWidget(
                      // song: null,
                      ),
                ));
          },
          child: const Icon(Icons.add)),
    );
  }
}

Widget welcomeText() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Container(
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Hello Anatoly,",
            style: (TextStyle(fontFamily: 'Schyler', fontSize: 20)),
          ),
          Stack(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2022/06/21/08/57/male-7275449_960_720.jpg",
                    fit: BoxFit.fill,
                    height: 60,
                    width: 55,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                      alignment: Alignment.center,
                      height: 23,
                      width: 22,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Icon(
                        Icons.recycling,
                        color: Colors.blue,
                        size: 20,
                      )
                      ),
                ),
              ),

            ],
          )
        ],

      ),
    ),
  );
}

Widget textfeld() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          //width: MediaQuery.of(context).size.width,
          width: 250,
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          // ignore: prefer_const_constructors
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            style: const TextStyle(
                fontFamily: 'Schyler', fontSize: 23, color: Colors.grey),
            decoration: const InputDecoration(
              hintText: "Type a name, number ,  company, or keyword  ",
              hintStyle: TextStyle(color: Color.fromARGB(88, 58, 58, 58)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buttoncard(Function sort, Function recent) {
  return Container(
    height: 70,
    padding: const EdgeInsets.all(3),
    margin: const EdgeInsets.only(top: 3),
    width: double.infinity,
    // MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: Color(0xffFFFFFF),
    ),
    child: Row(
      children: [
        TextButton(
            onPressed: () {
              sort();
            },
            child: const Text(
              'ABC',
              style: TextStyle(color: Colors.black),
            )),
        TextButton(
            onPressed: () {
              recent();
            },
            child: const Text(
              'Recent',
              style: TextStyle(color: Colors.black),
            )),
        const SizedBox(
          width: 170,
        ),
        SvgPicture.asset(
          'asstes/images/dot.svg',
          color: Colors.orange,
          height: 15.0,
          width: 15.0,
          allowDrawingOutsideViewBox: true,
        ),
        const SizedBox(
          width: 15,
        ),
        SvgPicture.asset(
          'asstes/images/dot.svg',
          color: Colors.red,
          height: 15.0,
          width: 15.0,
          allowDrawingOutsideViewBox: true,
        ),
      ],
    ),
  );
}

Widget singlecard(ContactModel contact, int index) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 24, 10, 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(contact.avatar),
            ),
            if (index == 0 || index == 4)
              Positioned(
                bottom: 0.0,
                right: -1,
                child: SvgPicture.asset(
                  'asstes/images/dot.svg',
                  color: Colors.orange,
                  height: 15.0,
                  width: 15.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            if (index == 1)
              Positioned(
                bottom: 0.0,
                right: -1,
                child: SvgPicture.asset(
                  'asstes/images/dot.svg',
                  color: Colors.red,
                  height: 15.0,
                  width: 15.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
          ],
        ),
        // Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //         //color: Colors.black,
        //         borderRadius: BorderRadius.circular(30.0),
        //         image: DecorationImage(
        //           fit: BoxFit.fill,
        //           image: NetworkImage(
        //               "https://cdn.pixabay.com/photo/2022/05/31/09/37/toddler-7233172_960_720.jpg"),
        //         ))),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  contact.name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              contact.job,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        )
      ],
    ),
  );
}

Widget buildList(ContactListModel contactList, Function removeItem) {
  return Expanded(
    child: ListView.builder(
      itemCount: contactList.contactList.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            background: Container(
              color: Colors.red,
              child: Row(
                children: [
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'delet   ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: const [
                      Text(
                        '   update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ))
                ],
              ),
            ),
            key: Key(contactList.contactList[index].id.toString()),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(
                          contactModel: contactList.contactList[index],
                          // song: null,
                        ),
                      ));
                },
                child: singlecard(contactList.contactList[index], index)),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(Icons.close))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Are you sure ?',
                                      style: TextStyle(fontSize: 23),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  children: const [
                                    Text(
                                      'Seems like you have chosen to delete your contact',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            const Divider(
                                height: 1, color: Colors.grey, thickness: 2),
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: const Text(
                                          'No,do not delete',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              overflow: TextOverflow.clip,
                                              color: const Color.fromARGB(
                                                  255, 254, 35, 108)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        //contactList.contactList.removeAt(index);
                                        removeItem(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Yes, delete ',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              overflow: TextOverflow.clip,
                                              color: Color.fromARGB(
                                                  255, 254, 35, 108)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            });
      },
    ),
  );
}
