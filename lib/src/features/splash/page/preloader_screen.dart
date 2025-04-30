import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/features/auth/services/auth_service.dart';

class PreloaderCAnimated extends StatefulWidget {
  const PreloaderCAnimated({super.key});

  @override
  State<PreloaderCAnimated> createState() => _PreloaderCAnimatedState();
}

class _PreloaderCAnimatedState extends State<PreloaderCAnimated>
    with SingleTickerProviderStateMixin {
  final String fullText = "rediBridge";
  String visibleText = "";
  int index = 0;

  late final Timer _textTimer;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _textTimer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (index < fullText.length) {
        setState(() {
          visibleText += fullText[index];
          index++;
        });
      } else {
        _textTimer.cancel();
        _checkSession(); // Verificamos sesión cuando termina la animación
      }
    });
  }

  Future<void> _checkSession() async {
    final token = await SessionManager.getToken();

    // Esperamos un poco para terminar animación
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    if (token != null) {
      final user = await AuthService.getProfile();
      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardPage(user: user)),
        );
        return;
      }
    }

    // Si no hay sesión activa, mandamos al login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _textTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'C',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: visibleText),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _controller,
              child: const Icon(
                Icons.circle,
                size: 46,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
