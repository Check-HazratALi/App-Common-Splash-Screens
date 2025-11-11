import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:app_common_widgets/screens/splash_screens/animated_splash_1/transfelry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
//
// Created by CodeWithFlexZ
// Tutorials on my YouTube
//
//! Instagram
//! @CodeWithFlexZ
//
//? GitHub
//? AmirBayat0
//
//* YouTube
//* Programming with FlexZ
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapping the app in MaterialApp to manage app-wide configurations
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Initial screen is the splash screen
    );
  }
}

