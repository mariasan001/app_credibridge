import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'mas_options_sheet.dart'; // Asegúrate de importar correctamente

class CapsuleBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;
  final User user;
  final VoidCallback onLogout;

  const CapsuleBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': LineIcons.home, 'label': 'Inicio'},
      {'icon': LineIcons.exclamationCircle, 'label': 'Quejas'},
      {'icon': LineIcons.fileContract, 'label': 'Contratos'},
      {'icon': LineIcons.verticalEllipsis, 'label': 'Más'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = selectedIndex == index;
          final item = items[index];

          return GestureDetector(
            onTap: () {
              if (index == 3) {
                // Mostrar hoja inferior (más opciones)
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => MasOptionsSheet(
                    user: user,
                    onLogout: onLogout,
                  ),
                );
              } else {
                onTabChanged(index);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: isSelected
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  : const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 54, 54, 54)
                    : const Color.fromARGB(0, 53, 53, 53),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 20,
                    color: isSelected
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(179, 0, 0, 0),
                  ),
                  if (isSelected && index != 3) ...[
                    const SizedBox(width: 8),
                    Text(
                      item['label'],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
