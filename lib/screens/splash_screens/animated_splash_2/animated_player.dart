import 'package:app_common_widgets/screens/splash_screens/animated_splash_1/transfelry.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScree extends StatefulWidget {
  const SplashScree({super.key});

  @override
  State<SplashScree> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Define the core color (Vibrant Green)
  static const Color _vibrantGreen = Color(0xFF4CAF50); // A bright green
  static const Color _darkerGreen = Color(
    0xFF1B5E20,
  ); // A darker green for depth

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next screen here
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper method to create a pulsing icon
  Widget _buildMusicIcon() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Calculate scale and glow based on controller value
        final pulseValue =
            (math.sin(_controller.value * 2 * math.pi) + 1) / 2; // 0.0 to 1.0
        final scale = 1.0 + (pulseValue * 0.1); // Scale from 1.0 to 1.1

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _vibrantGreen.withOpacity(0.5 + pulseValue * 0.3),
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Icon(Icons.music_note, color: _vibrantGreen, size: 50),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 1. Radial Gradient Background (Simulating the shift)
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [_vibrantGreen, _darkerGreen],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 2. Wave Animation (CustomPainter)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Wave 1: Primary, brighter wave
                return CustomPaint(
                  painter: WavePainter(
                    animationValue: _controller.value,
                    color: Colors.white.withOpacity(0.4),
                    amplitude: 25.0,
                    frequency: 2.0,
                    phaseOffset: 0.0,
                  ),
                  child: Container(),
                );
              },
            ),
            // Wave 2: Secondary, fainter wave for depth
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                    animationValue: _controller.value,
                    color: Colors.white.withOpacity(0.2),
                    amplitude: 15.0,
                    frequency: 3.0,
                    phaseOffset: math.pi / 2, // Start phase offset
                  ),
                  child: Container(),
                );
              },
            ),

            // 3. Main Content (Icon and Text)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 5),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final scale =
                        1.0 +
                        0.05 * (math.sin(_controller.value * 2 * math.pi));
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: _buildMusicIcon(),
                ),
                const Spacer(flex: 5),

                // Music Icon with Pulse
                const SizedBox(height: 30),

                // Title Text
                const Text(
                  'Flexysplash',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle Text
                const Text(
                  'Feel the Music, Live the Vibe',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.white70,
                    letterSpacing: 1.0,
                  ),
                ),

                const SizedBox(height: 50),

                // Placeholder for loading bar / pulsing dots
                SizedBox(
                  width: 150,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        value: _controller.value,
                      );
                    },
                  ),
                ),

                const Spacer(flex: 4),
              ],
            ),

            // 4. Simple Particle Simulation (Small, randomly placed fading circles)
            ..._buildParticles(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildParticles() {
    final random = math.Random(42); // Seed for consistent particle layout
    return List.generate(20, (index) {
      final size = 3.0 + random.nextDouble() * 5.0; // Random size
      final x = (random.nextDouble() * 2 - 1) * 0.9; // -0.9 to 0.9
      final y = (random.nextDouble() * 2 - 1) * 0.9; // -0.9 to 0.9

      return Positioned.fill(
        child: Align(
          alignment: Alignment(x, y),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final flicker =
                  (math.sin(_controller.value * 2 * math.pi + index) + 1) / 2;
              return Opacity(
                opacity: 0.3 + flicker * 0.5,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double amplitude;
  final double frequency;
  final double phaseOffset;

  WavePainter({
    required this.animationValue,
    required this.color,
    required this.amplitude,
    required this.frequency,
    required this.phaseOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    final centerH = size.height / 2;

    path.moveTo(0, centerH);

    for (double x = 0; x <= size.width; x++) {
      final phaseShift = animationValue * 2 * math.pi;
      final y =
          centerH +
          amplitude *
              math.sin(
                (frequency * x / size.width) * 2 * math.pi +
                    phaseShift +
                    phaseOffset,
              );

      path.lineTo(x, y);
    }

    path.moveTo(size.width, centerH + 5);

    for (double x = size.width; x >= 0; x--) {
      final phaseShift = animationValue * 2 * math.pi;

      final y =
          centerH +
          5 +
          (amplitude * 0.8) *
              math.sin(
                (frequency * x / size.width) * 2 * math.pi +
                    phaseShift +
                    phaseOffset +
                    0.1,
              );

      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
