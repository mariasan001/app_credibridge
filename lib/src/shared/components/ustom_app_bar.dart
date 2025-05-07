import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const CustomAppBar({
    super.key,
    required this.user,
  });

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
      actions: [
        // Notificaciones
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0EA), // fondo claro tipo beige
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: 25,
          ),
        ),

        // Ícono de opciones tipo "grid"
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: const Icon(
            Icons.grid_view_outlined,
            color: Colors.black,
            size: 25,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
