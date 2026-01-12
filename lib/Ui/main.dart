// Entry point of the application

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Ui/HomeScreen.dart';

void main() {
  // Starts the Flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: "Weather App",

      // App theme
      theme: ThemeData(primarySwatch: Colors.blue),

      // First screen of app
      home: const Homescreen(),
    );
  }
}
