import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import '../widgets/login_form.dart';
import '../widgets/logo_title.dart';
import '../../../shared/components/welcome_text.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool showContainer = false;

  @override
  void initState() {
    super.initState();

    /// Permitir la entrada animada después de un pequeño retardo
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => showContainer = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final double screenHeight = 1.sh;

    final double logoTop = showContainer
        ? (isKeyboardVisible ? 60.h : screenHeight * 0.12)
        : screenHeight * 0.05;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // cerrar teclado al tocar fuera
        child: Stack(
          children: [
            /// LOGO ANIMADO
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              top: logoTop,
              left: 0,
              right: 0,
              child: const Center(child: LogoTitle()),
            ),

            /// FORMULARIO
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              bottom: showContainer ? 0 : -600.h,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    )
                  ],
                ),
                child: const _LoginBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // ✅ Mejora en caso de teclado activo
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeText(
            titlePrefix: 'Bienvenidos a',
            titleHighlight: 'CrediBridge',
            titleSuffix: 'toma el control de tus finanzas',
            subtitle: 'Introduce tu información y descubre tus opciones de crédito.',
          ),
          SizedBox(height: 24.h),
          const LoginForm(),
          SizedBox(height: 24.h),
          Center(
            child: Text(
              'Aviso de privacidad',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
