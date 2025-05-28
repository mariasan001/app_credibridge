import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_historial_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/seleccionar_financiera_page.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/ticket_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/tiket_card.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistorialSolicitudesPage extends StatefulWidget {
  final User user;

  const HistorialSolicitudesPage({super.key, required this.user});

  @override
  State<HistorialSolicitudesPage> createState() =>
      _HistorialSolicitudesPageState();
}

class _HistorialSolicitudesPageState extends State<HistorialSolicitudesPage> {
  late Future<List<TicketHistorialModel>> _ticketsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = TicketService.getHistorialByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con botón de crear
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Historial",
                  style: AppTextStyles.promoTitle(
                    context,
                  ).copyWith(fontSize: 20.sp),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                ReportePaso1FinancieraPage(user: widget.user),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: Text(
                    "Crear reporte",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.text(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Lista de tickets
            Expanded(
              child: FutureBuilder<List<TicketHistorialModel>>(
                future: _ticketsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Ocurrió un error al cargar tus solicitudes.",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }

                  final tickets = snapshot.data ?? [];

                  if (tickets.isEmpty) {
                    return Center(
                      child: Text(
                        "Aún no tienes solicitudes registradas.",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: tickets.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder:
                        (_, index) => TicketCard(ticket: tickets[index], user: widget.user,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
