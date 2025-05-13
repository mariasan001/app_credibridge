import 'package:app_creditos/src/features/nuevo_user/correo/widget/correofield.dart';
import 'package:app_creditos/src/features/recuperar_pasword/correo/services/correo_service.dart';

import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class RcorreoPage extends StatefulWidget {
  const RcorreoPage({super.key});

  @override
  State<RcorreoPage> createState() => _RcorreoPageState();
}

class _RcorreoPageState extends State<RcorreoPage> {
  bool showContainer = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  /// Envía el token de recuperación al correo ingresado
  Future<void> _enviarToken() async {
    if (!_formKey.currentState!.validate()) return;

    final correo = _correoController.text.trim();
    setState(() => _isLoading = true);

    try {
      await RecuperarCorreoService.enviarTokenRecuperacion(email: correo);

      if (!mounted) return;
      Navigator.pushNamed(context, '/token_recuperar');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 300;

    final horizontalPadding = isTablet ? 70.0 : 24.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop =
        showContainer ? (isKeyboardVisible ? 250.0 : (isTablet ? 450.0 : 180.0)) : 50.0;

    return Scaffold(
      backgroundColor:AppColors.background(context),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: showContainer ? 0 : -600,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const WelcomeText(
                      titlePrefix: '¿Olvidaste tu',
                      titleHighlight: 'contraseña?',
                      titleSuffix: '',
                      subtitle: 'Ingresa el correo asociado a tu cuenta para enviarte un token de recuperación.',
                    ),
                    const SizedBox(height: 32),
                    CorreoField(controller: _correoController),
                    const SizedBox(height: 64),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: 'Enviar Token',
                        isLoading: _isLoading,
                        onPressed: _enviarToken,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Aviso de privacidad',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
