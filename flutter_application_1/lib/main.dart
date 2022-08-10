import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/contact_about.dart';
import 'package:flutter_application_1/ui/home/contact_creation.dart';
import 'package:flutter_application_1/ui/home/contact_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
      //home: AboutWidget(),
      //home: CreationWidget(),

      debugShowCheckedModeBanner: false,
    );
  }
}
