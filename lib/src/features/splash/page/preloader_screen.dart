import 'dart:async';
import 'package:app_creditos/src/shared/theme/preloader_loader_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/features/auth/services/auth_service.dart';

/// Pantalla de preloader con animación de texto y barra de carga.
/// Muestra "CrediBridge" letra por letra, y luego redirige según el estado de sesión.
class PreloaderCAnimated extends StatefulWidget {
  const PreloaderCAnimated({super.key});

  @override
  State<PreloaderCAnimated> createState() => _PreloaderCAnimatedState();
}

class _PreloaderCAnimatedState extends State<PreloaderCAnimated>
    with SingleTickerProviderStateMixin {
  final String fullText = "Bridge"; // Texto que se revelará después de "Credi"
  String visibleText = "";
  int index = 0;

  late final Timer _textTimer;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Animación de fade para la barra de carga (opcional si quieres que parpadee)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Inicia la animación del texto letra por letra
    _textTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index < fullText.length) {
        setState(() {
          visibleText += fullText[index];
          index++;
        });
      } else {
        _textTimer.cancel();
        _checkSession(); // Verifica sesión al terminar la animación
      }
    });
  }

  /// Verifica si hay sesión activa y redirige según corresponda
  Future<void> _checkSession() async {
    final token = await SessionManager.getToken();
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    if (token != null) {
      final user = await AuthService.getProfile();
      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
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
      backgroundColor: AppColors.background(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Marca con texto animado
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Credi", style: AppTextStyles.logoHighlight(context)),
                Text(visibleText, style: AppTextStyles.logoText(context)),
              ],
            ),
            const SizedBox(height: 24),

            // Barra de carga horizontal reutilizable
            FadeTransition(
              opacity: _controller,
              child: const PreloaderLoaderBar(),
            ),
          ],
        ),
      ),
    );
  }
}
