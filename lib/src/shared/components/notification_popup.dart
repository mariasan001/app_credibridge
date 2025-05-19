import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color orange = const Color(0xFFFF8C00);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closePopup,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            left: offset.dx - 200.w + size.width / 2,
            top: offset.dy + size.height + 6.h,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 320.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey.shade800 : const Color(0xFFF4F4F4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_off_outlined,
                        size: 28.sp,
                        color: isDark ? orange : Colors.black54,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Sin notificaciones',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Vuelve pronto para revisar tus actualizaciones.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? Colors.white54 : Colors.grey,
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

  void _closePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color orange = const Color(0xFFFF8C00);

    return IconButton(
      key: _notifKey,
      icon: Icon(
        Icons.notifications_none,
        size: 24.sp,
        color: isDark ? orange : Colors.black,
      ),
      onPressed: _showPopup,
    );
  }
}
