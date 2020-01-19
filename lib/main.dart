import 'package:flutter/material.dart';
import 'package:staggered_animations/buttons_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staggered Animations Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonsPage(numberOfButtons: 6),
    );
  }
}
