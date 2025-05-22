import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor; // Opcional
  final double radius;

  const TicketContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define el color de fondo por defecto según el tema
    final bgColor = backgroundColor ??
        (isDark ? const Color(0xFF2A2A2A) : const Color.fromARGB(255, 255, 255, 255));

    return CustomPaint(
      painter: _TicketPainter(backgroundColor: bgColor, radius: radius.r),
      child: ClipPath(
        clipper: _TicketClipper(radius: radius.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          color: bgColor,
          child: child,
        ),
      ),
    );
  }
}

class _TicketClipper extends CustomClipper<Path> {
  final double radius;

  _TicketClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    const notchCount = 20;
    final notchWidth = size.width / notchCount;

    path.moveTo(0, 0);

    // Muescas superiores
    for (int i = 0; i < notchCount; i++) {
      final x = i * notchWidth;
      path.arcToPoint(
        Offset(x + notchWidth / 2, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    }

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    // Muescas inferiores
    for (int i = notchCount; i > 0; i--) {
      final x = i * notchWidth;
      path.arcToPoint(
        Offset(x - notchWidth / 2, size.height),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    }

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _TicketPainter extends CustomPainter {
  final Color backgroundColor;
  final double radius;

  _TicketPainter({required this.backgroundColor, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    final clipper = _TicketClipper(radius: radius);
    final path = clipper.getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
