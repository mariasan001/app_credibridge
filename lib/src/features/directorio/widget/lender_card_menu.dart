import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/directorio/page/solicitud_page.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

PopupMenuButton<String> buildLenderCardMenu({
  required BuildContext context,
  required LenderService service,
  required void Function(BuildContext, String) onPhone,
  required void Function(BuildContext, String) onEmail,
}) {
  return PopupMenuButton<String>(
      tooltip: '',
    enableFeedback: false,
    splashRadius: 1,
    color: Colors.white,
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
      const PopupMenuItem(
        value: 'llamar',
        child: ListTile(
          leading: Icon(Icons.phone, size: 18),
          title: Text('Llamar'),
        ),
      ),
      const PopupMenuDivider(height: 1),
      const PopupMenuItem(
        value: 'correo',
        child: ListTile(
          leading: Icon(Icons.email, size: 18),
          title: Text('Mandar correo'),
        ),
      ),
      const PopupMenuDivider(height: 1),
      const PopupMenuItem(
        value: 'informes',
        child: ListTile(
          leading: Icon(Icons.info_outline, size: 18),
          title: Text('Pedir informes'),
        ),
      ),
    ],
    icon: const Icon(Icons.more_vert, size: 20),
  );
}
