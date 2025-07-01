import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/historial_solicitudes_page.dart';
import 'package:app_creditos/src/features/solicitudes/page/page_solicitudes.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'mas_options_sheet.dart';

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
        color: AppColors.containernav(context),
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
                  backgroundColor: AppColors.fondoPrimary(context),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => MasOptionsSheet(
                    user: user,
                    onLogout: onLogout,
                  ),
                );
              } else {
                onTabChanged(index); // actualiza estado en MainPage

                // Navegación a otras páginas
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistorialSolicitudesPage(user: user),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PageSolicitudes(user: user),
                    ),
                  );
                }
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: isSelected
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  : const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.optionseelct(context) : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 20,
                    color: isSelected ? AppColors.textbtn(context) : AppColors.iconsbton(context),
                  ),
                  if (isSelected && index != 3) ...[
                    const SizedBox(width: 8),
                    Text(
                      item['label'],
                      style:  TextStyle(
                        color:AppColors.backgroundLight,
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

