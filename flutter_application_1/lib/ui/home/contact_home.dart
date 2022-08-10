// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/contac_service.dart';
import 'package:flutter_application_1/ui/home/contact_creation.dart';

import '../../model/contact_model.dart';
import 'contact_about.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late ContactListModel contactListModel;
  bool isDescending = false;

  @override
  void initState() {
    contactListModel = ContactListModel(
        contactList: [], errorModel: ErrorModel(statusCode: 200));

    getContactDataFromAPI();
    super.initState();
  }

  void getContactDataFromAPI() async {
    final value = await ContactService.fechcontact();
    setState(() {
      contactListModel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "Hello Anatoly,",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          "https://cdn.pixabay.com/photo/2022/06/15/17/14/little-girl-7264330_960_720.jpg",
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      height: 40,
                      child: Icon(
                        Icons.recycling_sharp,
                        color: Color.fromARGB(255, 27, 134, 227),
                      ),
                    )

                    // (child: const Icon(Icons.recycling,))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            const TextField(
              style: TextStyle(fontFamily: 'Schyler'),
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                hintMaxLines: 2,
                hintText: "Type a name, number,  company, or keyword",
                hintStyle: TextStyle(color: Color.fromARGB(88, 58, 58, 58)),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                TextButton.icon(
                  icon: const RotatedBox(
                    quarterTurns: 1,
                  ),
                  label: Text(
                    isDescending ? 'Ascending' : 'Ascending',
                    style: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () => setState(() => isDescending = !isDescending),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {},
                    child: TextButton(
                      style: TextButton.styleFrom(
                        // primary: Colors.blue,
                        onSurface: Colors.black,
                      ),
                      onPressed: null,
                      child: const Text('Recent'),
                    )),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactListModel.contactList.length,
                  itemBuilder: (BuildContext context, int index) {
                    //final sortedItems = contactListModel.contactList
                    // ..sort((item1, item2) => isDescending
                    //   ? item2.compareTo(item1)
                    //  : item1.compareTo(item2));

                    // isDescending  ? contactListModel.contactList.reversed.toList()
                    //: contactListModel.contactList;
                    //final item = sortedItems[index];
                    final item = contactListModel.contactList[index];
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
                                    'delet',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )),
                              Container(
                                  child: Row(
                                children: [
                                  const Text(
                                    'update',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        key: Key(item.id.toString()),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return AboutWidget(
                                contactModel:
                                    contactListModel.contactList[index],
                              );
                            })));
                          },
                          child: cardwidget(
                            imageUrl:
                                contactListModel.contactList[index].avatar ??
                                    "",
                            name:
                                contactListModel.contactList[index].name ?? "",
                            job: contactListModel.contactList[index].job ?? "",
                            context: context,
                          ),
                        ),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Icon(Icons.close))
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'Are you sure ?',
                                                  style:
                                                      TextStyle(fontSize: 23),
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
                                            height: 1,
                                            color: Colors.grey,
                                            thickness: 2),
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: const Text(
                                                      'No,do not delete',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              254, 35, 108)),
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
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'Yes, delete ',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          color: Color.fromARGB(
                                                              255,
                                                              254,
                                                              35,
                                                              108)),
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
                  }),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreationWidget(
                      // song: null,
                      ),
                ));
          }),
    );
  }
}

Widget cardwidget({
  required String imageUrl,
  required String name,
  required String job,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 30, 10, 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                ))),
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
                  name,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              job,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        )
      ],
    ),
  );
}
