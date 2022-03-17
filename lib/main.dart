import 'package:finallexam/pages/create_page.dart';
import 'package:finallexam/pages/home_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Project',
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        HomePage.id:(context)=>HomePage(),
        CreatePage.id:(context)=>CreatePage()
      },
    );
  }}