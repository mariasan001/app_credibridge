import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Enlace para recuperación de contraseña.
/// Alineado a la derecha, responsivo y con navegación declarada.
class RecoveryLink extends StatelessWidget {
  const RecoveryLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Rcorreo');
        },
        child: Text(
          'Olvidé mi contraseña',
          style: AppTextStyles.linkMuted(context).copyWith(fontSize: 13.sp),
        ),
      ),
    );
  }
}
