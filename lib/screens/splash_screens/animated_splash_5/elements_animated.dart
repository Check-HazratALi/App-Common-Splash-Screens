import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class FlexySplashScreen extends StatefulWidget {
  const FlexySplashScreen({super.key});

  @override
  State<FlexySplashScreen> createState() => _FlexySplashScreenState();
}

class _FlexySplashScreenState extends State<FlexySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleOpacity;
  late Animation<double> _titleScale;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _subtitleOffset;
  late Animation<double> _particleScale;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Title animations
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    _titleScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.elasticOut),
      ),
    );

    // Subtitle animations
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeInOut),
      ),
    );

    _subtitleOffset = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    // Particle animation
    _particleScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    // Background color animation
    _backgroundColor = ColorTween(
      begin: const Color(0xFF6A11CB),
      end: const Color(0xFF2575FC),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _navigateToNextPage(BuildContext context) {
  //   // Add tap feedback animation
  //   final animationController = AnimationController(
  //     duration: const Duration(milliseconds: 200),
  //     vsync: this,
  //   );
    
  //   Tween<double>(begin: 1.0, end: 0.9).animate(
  //     CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
  //   );
    
  //   animationController.forward().then((_) {
  //     animationController.reverse().then((_) {
  //       animationController.dispose();
        
  //       // Navigate to next page with fade transition
  //       Navigator.of(context).push(
  //         PageRouteBuilder(
  //           pageBuilder: (context, animation, secondaryAnimation) => const SplashScree(),
  //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //             const begin = Offset(0.0, 1.0);
  //             const end = Offset.zero;
  //             const curve = Curves.easeInOut;
              
  //             var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //             var offsetAnimation = animation.drive(tween);
              
  //             return SlideTransition(
  //               position: offsetAnimation,
  //               child: FadeTransition(
  //                 opacity: animation,
  //                 child: child,
  //               ),
  //             );
  //           },
  //           transitionDuration: const Duration(milliseconds: 600),
  //         ),
  //       );
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColor.value ?? const Color(0xFF6A11CB),
                  _backgroundColor.value?.withOpacity(0.8) ??
                      const Color(0xFF2575FC).withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated particles in background
                ..._buildAnimatedParticles(),
                
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main Title with animations
                      Transform.scale(
                        scale: _titleScale.value,
                        child: Opacity(
                          opacity: _titleOpacity.value,
                          child: const Text(
                            'FlexySplash',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Subtitle with animations
                      Transform.translate(
                        offset: Offset(0, _subtitleOffset.value),
                        child: Opacity(
                          opacity: _subtitleOpacity.value,
                          child: const Text(
                            'Creative & Vibrant Animations',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.black26,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 60),
                      
                      // Tap to interact button
                      _buildAnimatedLoader(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildAnimatedParticles() {
    return [
      // Top Left Particle
      Positioned(
        top: 100,
        left: 50,
        child: Transform.scale(
          scale: _particleScale.value,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
      ),
      
      // Top Right Particle
      Positioned(
        top: 80,
        right: 70,
        child: Transform.scale(
          scale: _particleScale.value * 0.8,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
        ),
      ),
      
      // Bottom Left Particle
      Positioned(
        bottom: 120,
        left: 80,
        child: Transform.scale(
          scale: _particleScale.value * 0.6,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
        ),
      ),
      
      // Bottom Right Particle
      Positioned(
        bottom: 80,
        right: 50,
        child: Transform.scale(
          scale: _particleScale.value * 0.7,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildAnimatedLoader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      width: 200,
      height: 60 + sin(_controller.value * 2 * pi) * 4, // Subtle breathing effect
      margin: EdgeInsets.only(
        top: 20 + sin(_controller.value * 4 * pi) * 2, // Very subtle floating
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
          ),
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
            ),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                print("heeeeeeeee");
              },
              splashColor: Colors.white.withOpacity(0.3),
              highlightColor: Colors.white.withOpacity(0.1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                      spreadRadius: 1,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        color: const Color(0xFF667eea),
                        size: 24,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Tap to interact!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF667eea),
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Next page example
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2575FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You tapped the button!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2575FC),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
