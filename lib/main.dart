
import 'package:flutter/material.dart';
import 'package:newsapp/screen/homescreen.dart';



void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen()
    );
  }
}
