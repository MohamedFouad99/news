// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:news/details/details_screen.dart';

import 'package:news/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news',
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailsScreen.Route_Name: (context) => DetailsScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Color(0xFF39A552),
        appBarTheme: AppBarTheme(
          color: Color(0xFF39A552),
        ),
      ),
    );
  }
}
