import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class PerfilPage extends StatefulWidget {
  final User user;

  const PerfilPage({super.key, required this.user});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => _isLoading = false);
    });
  }

  Widget buildField(IconData icon, String label, String value, {bool enabled = false}) {
    final isStatusField = label == 'Situación';
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, size: 18.sp, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                if (isStatusField && value.toLowerCase().contains('activa'))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  TextFormField(
                    initialValue: value,
                    enabled: enabled,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<Widget> fields) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp)),
          SizedBox(height: 16.h),
          ...fields,
        ],
      ),
    );
  }

  Widget buildSkeletonSection() {
    Widget shimmerLine({double width = double.infinity}) => Container(
      height: 14.h,
      width: width.w,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    Widget shimmerField() => Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          CircleAvatar(radius: 18.r, backgroundColor: Colors.grey[300]),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(children: [shimmerLine(width: 100), shimmerLine()]),
          ),
        ],
      ),
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300!,
      highlightColor: Colors.grey.shade100!,
      child: Column(
        children: List.generate(4, (_) => buildSection("", List.generate(4, (_) => shimmerField()))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final pagePadding = isTablet ? 20.w : 16.w;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: _isLoading
          ? Padding(padding: EdgeInsets.all(pagePadding), child: buildSkeletonSection())
          : SingleChildScrollView(
              padding: EdgeInsets.all(pagePadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          'Mi perfil',
                          style: AppTextStyles.heading(context).copyWith(fontSize: 20.sp),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _isEditing = !_isEditing),
                        style: TextButton.styleFrom(
                          backgroundColor: _isEditing ? Colors.green : Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(_isEditing ? 'Guardar' : 'Actualizar'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  buildSection("Datos Personales", [
                    buildField(Icons.person, 'Nombre completo', user.name, enabled: _isEditing),
                    buildField(Icons.perm_identity, 'CURP', user.curp ?? '', enabled: _isEditing),
                    buildField(Icons.fingerprint, 'RFC', user.rfc ?? '', enabled: _isEditing),
                    buildField(Icons.badge, 'Número de Servidor Público', user.userId),
                  ]),
                  buildSection("Contacto", [
                    buildField(Icons.email, 'Correo electrónico', user.email ?? '', enabled: _isEditing),
                    buildField(Icons.phone, 'Teléfono', user.phone ?? '', enabled: _isEditing),
                  ]),
                  buildSection("Datos Laborales", [
                    buildField(Icons.apartment, 'Dependencia', user.workUnit?.desc ?? ''),
                    buildField(Icons.credit_card, 'Nómina', user.bank?.desc ?? ''),
                    buildField(Icons.work_outline, 'Puesto', user.jobCode?.desc ?? ''),
                    buildField(Icons.date_range, 'Fecha de ocupación', user.occupationDate ?? ''),
                    buildField(Icons.verified, 'Situación', user.positionStatus?.desc ?? ''),
                    buildField(Icons.security, 'Estatus de usuario', user.userStatus?.desc ?? ''),
                  ]),
                  buildSection("Roles", user.roles.isNotEmpty
                      ? user.roles
                          .map((rol) => buildField(Icons.check_circle, 'Rol asignado', rol.description))
                          .toList()
                      : [buildField(Icons.info, 'Rol asignado', 'Sin rol')]),
                ],
              ),
            ),
    );
  }
}
