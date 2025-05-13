import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

// Importas de los componentes
import 'package:app_creditos/src/shared/components/notification_popup.dart';
import 'package:app_creditos/src/shared/components/theme_toggle_button.dart';
import 'package:app_creditos/src/shared/components/options_menu.dart';

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
                fontSize: 25,
              ),
            ),
            const TextSpan(
              text: 'Bring',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      actions: const [
        NotificationPopupButton(),
        ThemeToggleButton(),
        OptionsMenuButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
