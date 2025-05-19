import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/features/nuevo_user/pass_new_user/page/pass_new_user.dart';
import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';
import 'package:app_creditos/src/features/nuevo_user/token/widget/otp_input.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class TokenRecuperarPage extends StatefulWidget {
  const TokenRecuperarPage({super.key});

  @override
  State<TokenRecuperarPage> createState() => _TokenRecuperarPageState();
}

class _TokenRecuperarPageState extends State<TokenRecuperarPage> {
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

    final double logoTop =
        showContainer ? (isKeyboardVisible ? 220.h : 120.h) : 50.h;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Stack(
        children: [
          // 🌀 Logo
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),

          // 🧾 Formulario
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: showContainer ? 0 : -600.h,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
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

                  SizedBox(height: 32.h),

                  OtpInput(
                    onCompleted: (code) {
                      setState(() {
                        _codigoIngresado = code;
                      });
                    },
                  ),

                  SizedBox(height: 48.h),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Validar Token',
                      isLoading: _isLoading,
                      onPressed: _validarToken,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Center(
                    child: Text(
                      'Aviso de privacidad',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10.sp),
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
