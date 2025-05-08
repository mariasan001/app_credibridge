// directorio_utils.dart
import 'package:flutter/material.dart';

Color getColorForService(String type) {
  switch (type.toLowerCase()) {
    case 'funeraria': return const Color(0xFF77BFA3);
    case 'préstamo': return const Color(0xFFE9A937);
    case 'seguro': return const Color(0xFF3A80BA);
    case 'productos': return const Color(0xFF735D78);
    default: return const Color(0xFFB0B0B0);
  }
}

IconData getIconForService(String type) {
  switch (type.toLowerCase()) {
    case 'funeraria': return Icons.favorite;
    case 'préstamo': return Icons.account_balance_wallet;
    case 'seguro': return Icons.verified_user;
    case 'productos': return Icons.shopping_bag;
    default: return Icons.business;
  }
}
