import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/page/registro_page.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Enlace que lleva al usuario a la pantalla de registro.
/// Centrado, responsivo y con estilos globales.
class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegistroPage(),
            ),
          );
        },
        child: Text(
          'Quiero registrarme',
          style: AppTextStyles.linkBold(context).copyWith(fontSize: 13.sp),
        ),
      ),
    );
  }
}
