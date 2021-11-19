import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:jsonassignment/screens/MyHomePage.dart';
=======
import 'package:jsonassignment/Screens/MyHomePage.dart';
>>>>>>> 8b0789ce6e7adfd6dcf1e60a3d3d6f274718a1a6

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Avenir',
      ),
      home: MyHomePage(),
    );
  }
}

