// lib/login_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  int? _attemptsLeft;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _attemptsLeft = null;
    });

    try {
      final result = await ApiService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (result['success']) {
        final data = result['data'];
        // ✅ Login successful – save session
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', json.encode(data['user']));
        await prefs.setBool('isLoggedIn', true);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        setState(() {
          _errorMessage = result['message'];
          _attemptsLeft = result['attempts_left'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error. Check your connection.';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.oatMilk,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Brand mark (same as splash) ---
                  CustomPaint(
                    size: const Size(80, 80),
                    painter: _SyrnLoginBrandPainter(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'syrn',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                      color: AppTheme.graphite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SIGN IN',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppTheme.graphite.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // --- Email field ---
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.inter(color: AppTheme.graphite),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: AppTheme.lovePotion),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email required';
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Password field ---
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: GoogleFonts.inter(color: AppTheme.graphite),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline, color: AppTheme.lovePotion),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // --- Attempts left warning ---
                  if (_attemptsLeft != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, size: 16, color: AppTheme.lovePotion),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Invalid password. $_attemptsLeft attempt(s) left.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.lovePotion,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 32),

                  // --- Login button ---
                  _isLoading
                      ? const CircularProgressIndicator(color: AppTheme.lovePotion)
                      : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                    ),
                    child: const Text('LOGIN'),
                  ),

                  const SizedBox(height: 20),

                  // --- Error message ---
                  if (_errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.lovePotion.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppTheme.lovePotion,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: 40),

                  // --- Elegant divider ---
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.ballerina.withOpacity(0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'NEW HERE?',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            letterSpacing: 1,
                            color: AppTheme.graphite.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: AppTheme.ballerina.withOpacity(0.3))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'CREATE AN ACCOUNT',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.graphite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Mini brand painter for login screen (simplified)
class _SyrnLoginBrandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final pollenPaint = Paint()..color = AppTheme.pollen;
    canvas.drawCircle(center, radius * 0.7, pollenPaint);
    final ballerinaPaint = Paint()
      ..color = AppTheme.ballerina
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;
    canvas.drawCircle(center, radius * 0.55, ballerinaPaint);
    final lovePaint = Paint()..color = AppTheme.lovePotion;
    final offsetCenter = Offset(center.dx + radius * 0.2, center.dy - radius * 0.1);
    canvas.drawCircle(offsetCenter, radius * 0.25, lovePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}