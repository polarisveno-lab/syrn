// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

/// Syrn Splash Screen – Premium, animated, fashion‑editorial style.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ------------------------- 1. Color Palette Tokens -------------------------
  static const Color oatMilk = Color(0xFFF8E3C4);
  static const Color pollen = Color(0xFFF0C283);
  static const Color graphite = Color(0xFF5D6973);
  static const Color lovePotion = Color(0xFFCF6E6C);
  static const Color ballerina = Color(0xFFDCA7A1);

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Animation controller: exactly 1200 ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 1. Fade: 0.0 → 1.0
    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    // 2. Scale: 0.92 → 1.0
    _scale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // 3. Slide: Offset(0.0, 0.05) → Offset.zero
    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start the animation immediately
    _controller.forward();

    // Timer for 3 seconds → check session and navigate
    _timer = Timer(const Duration(seconds: 3), () async {
      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
        if (mounted) {
          if (isLoggedIn) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: oatMilk,
      body: SafeArea(
        child: Stack(
          children: [
            // Center branding cluster
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slide,
                      child: ScaleTransition(
                        scale: _scale,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ---- Premium geometric branding mark ----
                    CustomPaint(
                      size: const Size(120, 120),
                      painter: _SyrnBrandPainter(),
                    ),
                    const SizedBox(height: 24),
                    // ---- App title "syrn" ----
                    Text(
                      'syrn',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 56,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4.0,
                        color: graphite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // ---- Subtitle ----
                    Text(
                      'SKINCARE INTELLIGENCE',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.8,
                        color: graphite.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom accent: minimalist loading bar (ballerina)
            Positioned(
              left: 0,
              right: 0,
              bottom: 48,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: ballerina.withOpacity(0.3),
                ),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    // Let the bar grow from 0% to 100% over the animation
                    final value = _controller.value; // 0.0 → 1.0
                    return FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: ballerina,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the abstract geometric brand mark.
/// Uses lovePotion, ballerina, and pollen for a premium, editorial look.
class _SyrnBrandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // ---- Base circle (pollen) ----
    final pollenPaint = Paint()
      ..color = const Color(0xFFF0C283) // pollen
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.7, pollenPaint);

    // ---- Soft accent ring (ballerina) ----
    final ballerinaPaint = Paint()
      ..color = const Color(0xFFDCA7A1) // ballerina
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;
    canvas.drawCircle(center, radius * 0.55, ballerinaPaint);

    // ---- Overlapping small circle (lovePotion) ----
    final lovePaint = Paint()
      ..color = const Color(0xFFCF6E6C) // lovePotion
      ..style = PaintingStyle.fill;
    final offsetCenter = Offset(center.dx + radius * 0.2, center.dy - radius * 0.1);
    canvas.drawCircle(offsetCenter, radius * 0.28, lovePaint);

    // ---- Elegant leaf / tear shape using a path (ballerina highlight) ----
    final path = Path();
    final start = Offset(center.dx - radius * 0.35, center.dy + radius * 0.2);
    final control1 = Offset(center.dx - radius * 0.1, center.dy + radius * 0.55);
    final control2 = Offset(center.dx + radius * 0.2, center.dy + radius * 0.4);
    final end = Offset(center.dx + radius * 0.45, center.dy + radius * 0.05);
    path.moveTo(start.dx, start.dy);
    path.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, end.dx, end.dy);
    path.close();
    canvas.drawPath(path, ballerinaPaint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}