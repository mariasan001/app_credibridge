import 'package:app_creditos/src/features/nuevo_user/pass_new_user/page/pass_new_user.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';

import 'package:app_creditos/src/features/nuevo_user/token/widget/otp_input.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  bool showContainer = false;
  bool _isLoading = false;
  String _codigoIngresado = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  void _validarToken() async {
  const String passwordTemporal = 'temporal123';

  print('🔐 Código actual ingresado: $_codigoIngresado');
  print('🔑 Contraseña temporal enviada: $passwordTemporal');

  if (_codigoIngresado.isEmpty || _codigoIngresado.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ingresa un código válido')),
    );
    return;
  }

  setState(() => _isLoading = true);

  try {
    await TokenService.verificarToken(
      code: _codigoIngresado,
      newPassword: passwordTemporal,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContrasenaPage(code: _codigoIngresado),
      ),
    );
  } catch (e) {
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
        showContainer
            ? (isKeyboardVisible ? 190.0 : (isTablet ? 350.0 : 180.0))
            : 50.0;

    return Scaffold(
      backgroundColor: AppColors.background,
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
                    titlePrefix: 'Revisa tu',
                    titleHighlight: 'correo electrónico',
                    titleSuffix: 'e ingresa tu código',
                    subtitle:
                        'Te enviamos un token de verificación. Por seguridad, este token fue enviado a tu correo registrado.',
                  ),
                  const SizedBox(height: 42),
                  OtpInput(
                    onCompleted: (code) {
                      setState(() {
                        _codigoIngresado = code;
                      });
                    },
                  ),

                  const SizedBox(height: 64),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Validar Token',
                      isLoading: _isLoading,
                      onPressed: _validarToken,
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
