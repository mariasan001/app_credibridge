// lib/src/features/auth/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import '../widgets/login_form.dart';
import '../widgets/logo_title.dart';
import '../widgets/welcome_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showContainer = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet ? 70.0 : 24.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop =
        showContainer
            ? (isKeyboardVisible ? 80.0 : (isTablet ? 300.0 : 180.0))
            : 50.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // LOGO animado
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),

          // FORMULARIO
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
              child: const _LoginBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const WelcomeText(),
        const SizedBox(height: 24),
        const LoginForm(),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Aviso de privacidad',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
