import 'package:flutter/material.dart';

class HomeCardButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const HomeCardButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
