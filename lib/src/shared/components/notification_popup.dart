import 'package:flutter/material.dart';

class NotificationPopupButton extends StatefulWidget {
  const NotificationPopupButton({super.key});

  @override
  State<NotificationPopupButton> createState() => _NotificationPopupButtonState();
}

class _NotificationPopupButtonState extends State<NotificationPopupButton> {
  final GlobalKey _notifKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showPopup() {
    final RenderBox renderBox = _notifKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset       = renderBox.localToGlobal(Offset.zero);
    final Size size           = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          /// Fondo transparente que cierra el popup al tocar fuera
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),

          /// Tarjeta emergente
          Positioned(
            left: offset.dx - 240 + size.width / 2,
            top:  offset.dy + size.height + 6,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : const Color(0xFFF4F4F4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_off_outlined,
                        size: 28,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white60
                            : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Sin notificaciones',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Vuelve pronto para revisar tus actualizaciones.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      key: _notifKey,
      icon: Icon(
        Icons.notifications_none,
        color: isDark ? Colors.white : Colors.black,
      ),
      onPressed: _showPopup,
    );
  }
}
