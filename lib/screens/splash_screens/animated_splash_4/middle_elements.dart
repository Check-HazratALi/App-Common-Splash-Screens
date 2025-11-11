// Define the main color from the image (a deep burnt orange)
import 'dart:ui';

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFCC6A2C);

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoBlurAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<double> _titleOffsetAnimation;
  late Animation<double> _subtitleOpacityAnimation;
  late Animation<double> _subtitleOffsetAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoBlurAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Title animations
    _titleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _titleOffsetAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    // Subtitle animations
    _subtitleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _subtitleOffsetAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // --- 1. Animated Glassmorphism Logo ---
                Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Opacity(
                    opacity: _logoOpacityAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2 * _logoOpacityAnimation.value),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: _logoBlurAnimation.value,
                            sigmaY: _logoBlurAnimation.value,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.2 * _logoOpacityAnimation.value),
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                    0.3 * _logoOpacityAnimation.value),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.piano_sharp,
                                size: 48,
                                color: Colors.white
                                    .withOpacity(_logoOpacityAnimation.value),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // --- 2. Animated Main Title Text ---
                Transform.translate(
                  offset: Offset(0, _titleOffsetAnimation.value),
                  child: Opacity(
                    opacity: _titleOpacityAnimation.value,
                    child: const Text(
                      'GuitarTune',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // --- 3. Animated Subtitle Text ---
                Transform.translate(
                  offset: Offset(0, _subtitleOffsetAnimation.value),
                  child: Opacity(
                    opacity: _subtitleOpacityAnimation.value,
                    child: const Text(
                      'Since 1952',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Alternative version with staggered entrance and continuous logo pulse
class FullyAnimatedSplashContent extends StatefulWidget {
  const FullyAnimatedSplashContent({super.key});

  @override
  State<FullyAnimatedSplashContent> createState() =>
      _FullyAnimatedSplashContentState();
}

class _FullyAnimatedSplashContentState extends State<FullyAnimatedSplashContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoBlurAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<double> _titleScaleAnimation;
  late Animation<double> _subtitleOpacityAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Pulse animation controller (starts after main animation)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Logo animations
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _logoBlurAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Title animations
    _titleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );

    _titleScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Subtitle animations
    _subtitleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9, curve: Curves.easeIn),
      ),
    );

    // Pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _controller.forward().then((_) {
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_controller, _pulseController]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // --- 1. Animated Glassmorphism Logo with continuous pulse ---
                Transform.scale(
                  scale: _logoScaleAnimation.value * _pulseAnimation.value,
                  child: Opacity(
                    opacity: _logoOpacityAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2 * _logoOpacityAnimation.value),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: _logoBlurAnimation.value,
                            sigmaY: _logoBlurAnimation.value,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.2 * _logoOpacityAnimation.value),
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                    0.3 * _logoOpacityAnimation.value),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.piano_sharp,
                                size: 48,
                                color: Colors.white
                                    .withOpacity(_logoOpacityAnimation.value),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // --- 2. Animated Main Title Text ---
                Transform.scale(
                  scale: _titleScaleAnimation.value,
                  child: Opacity(
                    opacity: _titleOpacityAnimation.value,
                    child: const Text(
                      'GuitarTune',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // --- 3. Animated Subtitle Text ---
                Opacity(
                  opacity: _subtitleOpacityAnimation.value,
                  child: const Text(
                    'Since 1952',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

