import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/preloader_loader_bar.dart';
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
  final String fullText = "Bridge";
  String visibleText = "";
  int index = 0;

  late final Timer _textTimer;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _textTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index < fullText.length) {
        setState(() {
          visibleText += fullText[index];
          index++;
        });
      } else {
        _textTimer.cancel();
        _checkSession();
      }
    });
  }

  Future<void> _checkSession() async {
    final token = await SessionManager.getToken();
    if (token != null) {
      final user = await AuthService.getProfile();
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
        );
        return;
      }
    }
    // 🟠 Si no hay token o es inválido:
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Marca con texto animado
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Credi",
                    style: AppTextStyles.logoHighlight(
                      context,
                    ).copyWith(fontSize: 32.sp),
                  ),
                  Text(
                    visibleText,
                    style: AppTextStyles.logoText(
                      context,
                    ).copyWith(fontSize: 32.sp),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              // Barra de carga animada
              FadeTransition(
                opacity: _controller,
                child: const PreloaderLoaderBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
