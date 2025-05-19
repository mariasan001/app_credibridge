import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

// Componentes externos
import 'package:app_creditos/src/shared/components/notification_popup.dart';
import 'package:app_creditos/src/shared/components/theme_toggle_button.dart';
import 'package:app_creditos/src/shared/components/options_menu_button.dart'; // Asegúrate de tenerlo

/// AppBar personalizado con logo, notificaciones y menú de usuario.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const CustomAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Credi',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 24.sp, // Escalado responsivo
              ),
            ),
            TextSpan(
              text: 'Bridge',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 24.sp,
              ),
            ),
          ],
        ),
      ),
      actions: [
        const NotificationPopupButton(),
        const ThemeToggleButton(),
        OptionsMenuButton(user: user), // ✅ Aquí ya sí aparece
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
