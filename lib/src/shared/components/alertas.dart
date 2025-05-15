import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final color = isError ? Colors.red[400] : Colors.green[400];
  final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}