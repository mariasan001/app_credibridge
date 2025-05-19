import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        style: TextButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
        ),
        child: Text(
          'Olvidé mi contraseña',
          style: TextStyle(
            color: AppColors.textMuted(context),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
