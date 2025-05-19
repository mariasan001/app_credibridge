import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';
import 'package:app_creditos/src/features/nuevo_user/pass_new_user/widgets/PasswordField.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/alertas.dart';

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
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      showCustomSnackBar(context, e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    final double logoTop = showContainer
        ? (isKeyboardVisible ? 160.h : 0.22.sh)
        : 60.h;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Stack(
        children: [
          // LOGO animado
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),

          // FORMULARIO animado
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeText(
                    titlePrefix: 'Crea una ',
                    titleHighlight: 'contraseña',
                    titleSuffix: '',
                    subtitle:
                        'Crea una contraseña de al menos 8 caracteres combinando letras, números y símbolos para mayor seguridad.',
                  ),
                  SizedBox(height: 36.h),
                  PasswordField(
                    label: 'Ingresa tu contraseña',
                    controller: _passController,
                  ),
                  SizedBox(height: 20.h),
                  PasswordField(
                    label: 'Nuevamente',
                    controller: _confirmPassController,
                  ),
                  SizedBox(height: 52.h),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Registrarme',
                      isLoading: _isLoading,
                      onPressed: _guardarContrasena,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: Text(
                      'Aviso de privacidad',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 10.sp),
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
