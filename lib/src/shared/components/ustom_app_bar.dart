import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/components/notification_popup.dart';
import 'package:app_creditos/src/shared/components/theme_toggle_button.dart';
import 'package:app_creditos/src/shared/components/options_menu_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const CustomAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Credi',
              style: TextStyle(
                color: const Color(0xFFFF8C00), // Naranja institucional o el que tú uses
                fontWeight: FontWeight.w900,
                fontSize: 24.sp,
              ),
            ),
            TextSpan(
              text: 'Bridge',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
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
        OptionsMenuButton(user: user),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
