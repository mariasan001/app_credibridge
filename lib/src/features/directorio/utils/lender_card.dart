import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_menu.dart';

class LenderCard extends StatelessWidget {
  final LenderService service;
  final String serviceType;

  const LenderCard({
    super.key,
    required this.service,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColorForService(serviceType);
    final icon = getIconForService(serviceType);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20,
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.lender.lenderName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service.lender.lenderEmail,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  service.lender.lenderPhone,
                  style: TextStyle(fontSize: 12, color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.white,
              popupMenuTheme: PopupMenuThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                textStyle: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            child: buildLenderCardMenu(
              context: context,
              service: service,
              onPhone: _tryLaunchPhone,
              onEmail: _tryLaunchEmail,
            ),
          ),
        ],
      ),
    );
  }

  void _tryLaunchPhone(BuildContext context, String number) async {
    final uri = Uri.parse('tel:$number');
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('No se pudo lanzar: $number');
        _showErrorSnackbar(context, 'No se pudo abrir la app de llamadas.');
      }
    } catch (e) {
      debugPrint('Error al intentar llamar: $number');
      _showErrorSnackbar(context, 'Error al intentar llamar.');
    }
  }

  void _tryLaunchEmail(BuildContext context, String email) async {
    final uri = Uri.parse('mailto:$email');
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('No se pudo abrir el correo: $email');
        _showErrorSnackbar(context, 'No se pudo abrir la app de correo.');
      }
    } catch (e) {
      debugPrint('Error al intentar abrir correo: $email');
      _showErrorSnackbar(context, 'Error al intentar abrir el correo.');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
