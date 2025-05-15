import 'package:flutter/material.dart';

import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';
import 'package:app_creditos/src/features/nuevo_user/pass_new_user/widgets/PasswordField.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/alertas.dart'; // ← ✅ Importa el nuevo SnackBar

class ContrasenaPage extends StatefulWidget {
  final String code;

  const ContrasenaPage({super.key, required this.code});

  @override
  State<ContrasenaPage> createState() => _ContrasenaPageState();
}

class _ContrasenaPageState extends State<ContrasenaPage> {
  bool showContainer = false;
  bool _isLoading = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  void _guardarContrasena() async {
    final nueva = _passController.text.trim();
    final confirmacion = _confirmPassController.text.trim();

    if (nueva != confirmacion || nueva.length < 8) {
      showCustomSnackBar(
        context,
        'Las contraseñas no coinciden o son inválidas',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await TokenService.verificarToken(
        code: widget.code,
        newPassword: nueva,
      );

      if (!mounted) return;

      showCustomSnackBar(
        context,
        'Contraseña actualizada correctamente',
        isError: false,
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;

      showCustomSnackBar(
        context,
        e.toString(),
        isError: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet ? 70.0 : 14.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop = showContainer
        ? (isKeyboardVisible ? 190.0 : (isTablet ? 350.0 : 180.0))
        : 50.0;

    return Scaffold(
      backgroundColor: AppColors.background(context),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WelcomeText(
                    titlePrefix: 'Crea una ',
                    titleHighlight: 'contraseña',
                    titleSuffix: '',
                    subtitle:
                        'Crea una contraseña de al menos 8 caracteres combinando letras, números y símbolos para mayor seguridad.',
                  ),
                  const SizedBox(height: 42),
                  PasswordField(
                    label: 'Ingresa tu contraseña',
                    controller: _passController,
                  ),
                  const SizedBox(height: 24),
                  PasswordField(
                    label: 'Nuevamente',
                    controller: _confirmPassController,
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Registrarme',
                      isLoading: _isLoading,
                      onPressed: _guardarContrasena,
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
        ],
      ),
    );
  }
}
