import 'package:drag_drop4/homeScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MatchGame',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
        );
  }
}