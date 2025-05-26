import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/features/solicitudes/page/solicitud_card_skeleton.dart';
import 'package:app_creditos/src/features/solicitudes/widget/solicitudes_card.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/features/solicitudes/services/contract_service.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

class PageSolicitudes extends StatefulWidget {
  final User user;
  const PageSolicitudes({super.key, required this.user});

  @override
  State<PageSolicitudes> createState() => _PageSolicitudesState();
}

class _PageSolicitudesState extends State<PageSolicitudes> {
  List<ContractModel> contratos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarContratos();
  }

  Future<void> cargarContratos() async {
    try {
      final result = await ContractService.getContractsByUser(
        widget.user.userId,
      );
      if (mounted) {
        setState(() {
          contratos = result;
          loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar solicitudes')),
        );
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body:
          loading
              ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                itemCount: 3,
                itemBuilder: (_, __) => const SolicitudCardSkeleton(),
              )
              : RefreshIndicator(
                onRefresh: cargarContratos,
                child:
                    contratos.isEmpty
                        ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              _buildHeader(context),
                              _buildEmptyState(context),
                            ],
                          ),
                        )
                        : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: contratos.length + 1,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            if (index == 0) return _buildHeader(context);
                            final contrato = contratos[index - 1];
                            return SolicitudCard(contrato: contrato);
                          },
                        ),
              ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HomePage(user: widget.user)),
                (route) => false,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
                SizedBox(width: 6.w),
                Text('Contratos', style: AppTextStyles.titleheader(context)),
              ],
            ),
          ),
          Text(
            'Aquí encontrarás el estatus de tus solicitudes.',
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(color: AppColors.textMuted(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                if (Theme.of(context).brightness == Brightness.light)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LineIcons.fileContract, size: 80.sp, color: Colors.orange),
                SizedBox(height: 20.h),
                Text(
                  'Aún no tienes solicitudes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Cuando realices una solicitud, podrás ver su estado aquí.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textMuted(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
