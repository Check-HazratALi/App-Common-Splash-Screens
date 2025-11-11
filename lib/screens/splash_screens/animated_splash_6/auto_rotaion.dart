import 'dart:math' as math;

import 'package:flutter/material.dart';

class AdvancedSplashScreen extends StatefulWidget {
  const AdvancedSplashScreen({super.key});

  @override
  _AdvancedSplashScreenState createState() => _AdvancedSplashScreenState();
}

class _AdvancedSplashScreenState extends State<AdvancedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Rotation from 0 to 2 pi (360 degrees) with easing curve
    _rotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Scale animation: scales up then down
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.2).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
    ]).animate(_controller);

    // Opacity animation: fade in and fade out
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 25),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 80, 73, 73),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value,
              child: Transform.rotate(
                angle: _rotation.value,
                child: Transform.scale(
                  scale: _scale.value,
                  child: child,
                ),
              ),
            );
          },
          child: Image.asset('assets/icons/plane.png', width: 200, height: 200),
        ),
      ),
    );
  }
}
