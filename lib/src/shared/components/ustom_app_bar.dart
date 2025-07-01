import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const CustomAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final puedeRegresar = Navigator.of(context).canPop();

    // Función para capitalizar palabras
    String capitalizar(String palabra) {
      if (palabra.isEmpty) return '';
      return palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();
    }

    // Obtener primer nombre y primer apellido
    final partesNombre = user.name.split(' ');
    final primerNombre =
        partesNombre.isNotEmpty ? capitalizar(partesNombre[0]) : '';
    final primerApellido =
        partesNombre.length > 1 ? capitalizar(partesNombre[1]) : '';

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading:
          puedeRegresar
              ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
              : null,
      titleSpacing: 14.w,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Saludo personalizado
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                color: isDark ? Colors.white : Colors.black87,
              ),
              children: [
                const TextSpan(text: 'Hola, '),
                TextSpan(
                  text: '$primerNombre $primerApellido!',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Íconos de acción
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: isDark ? Colors.white : Colors.black87,
                  size: 24.sp,
                ),
                onPressed: () {
                  // Acción de notificación
                },
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                radius: 18.r,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    'assets/img/img_perfil.jpg', // ruta a tu imagen
                    width: 40.sp,
                    height: 40.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 12.w),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
