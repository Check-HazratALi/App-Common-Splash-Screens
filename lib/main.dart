import 'dart:ui';

import 'package:app_common_widgets/screens/splash_screens/animated_splash_4/middle_elements.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashContent(),
      debugShowCheckedModeBanner: false,
    );
  }
}

