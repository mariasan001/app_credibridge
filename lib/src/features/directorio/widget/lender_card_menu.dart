import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/directorio/page/solicitud_page.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

PopupMenuButton<String> buildLenderCardMenu({
  required BuildContext context,
  required LenderService service,
  required void Function(BuildContext, String) onPhone,
  required void Function(BuildContext, String) onEmail,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final textColor = AppColors.text(context);

  return PopupMenuButton<String>(
    tooltip: '',
    splashRadius: 1.r,
    color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
    icon: Icon(Icons.more_vert, size: 20.sp, color: textColor),
    onSelected: (value) {
      switch (value) {
        case 'llamar':
          onPhone(context, service.lender.lenderPhone);
          break;
        case 'correo':
          onEmail(context, service.lender.lenderEmail);
          break;
        case 'informes':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SolicitudPage(service: service),
            ),
          );
          break;
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'llamar',
        child: ListTile(
          leading: Icon(Icons.phone, size: 18.sp, color: textColor),
          title: Text('Llamar', style: TextStyle(fontSize: 13.sp, color: textColor)),
        ),
      ),
      const PopupMenuDivider(height: 1),
      PopupMenuItem(
        value: 'correo',
        child: ListTile(
          leading: Icon(Icons.email_outlined, size: 18.sp, color: textColor),
          title: Text('Mandar correo', style: TextStyle(fontSize: 13.sp, color: textColor)),
        ),
      ),
      const PopupMenuDivider(height: 1),
      PopupMenuItem(
        value: 'informes',
        child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 400),
          closedElevation: 0,
          closedColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          openBuilder: (context, _) => SolicitudPage(service: service),
          closedBuilder: (context, openContainer) => ListTile(
            leading: Icon(Icons.info_outline, size: 18.sp, color: textColor),
            title: Text('Pedir informes', style: TextStyle(fontSize: 13.sp, color: textColor)),
            onTap: openContainer,
          ),
        ),
      ),
    ],
  );
}
