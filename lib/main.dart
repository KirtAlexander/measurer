import 'package:flutter/material.dart';
import 'package:measurer/home.page.dart';
import 'package:measurer/instructions_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medidor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  InstructionsPage(),
    );
  }
}
