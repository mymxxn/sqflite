import 'package:flutter/material.dart';

import 'package:untitledsqflite/add_contact.dart';
import 'package:untitledsqflite/homepage.dart';
import 'package:untitledsqflite/service/db.dart';


MyDb db =MyDb();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await db.open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: ListContacts(),
    );
  }
}


