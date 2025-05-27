import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/lista_categoria_widget.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/lista_financieras_widget.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/lista_tipos_ticket_widget.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/lender_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_cat.model.dart';

class TicketFormWidget extends StatelessWidget {
  final List<LenderModel> financieras;
  final LenderModel? selectedLender;
  final void Function(LenderModel) onSelectLender;

  final List<TicketTypeModel> tipos;
  final TicketTypeModel? selectedTipo;
  final void Function(TicketTypeModel) onSelectTipo;

  final bool mostrarClarifications;
  final List<ClarificationTypeModel> clarifications;
  final ClarificationTypeModel? selectedClarification;
  final void Function(ClarificationTypeModel) onSelectClarification;

  final TextEditingController subjectController;
  final TextEditingController descriptionController;
  final TextEditingController messageController;

  final VoidCallback onPickFile;
  final String? fileName;

  const TicketFormWidget({
    super.key,
    required this.financieras,
    required this.selectedLender,
    required this.onSelectLender,
    required this.tipos,
    required this.selectedTipo,
    required this.onSelectTipo,
    required this.mostrarClarifications,
    required this.clarifications,
    required this.selectedClarification,
    required this.onSelectClarification,
    required this.subjectController,
    required this.descriptionController,
    required this.messageController,
    required this.onPickFile,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            "Crear nuevo reporte",
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.cardBackground(context),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.promoShadow(context),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("¿A quién va dirigido?", context),
              SizedBox(height: 6.h),
              ListaFinancierasWidget(
                financieras: financieras,
                selectedLender: selectedLender,
                onTap: onSelectLender,
              ),
              SizedBox(height: 14.h),

              _buildSectionTitle("Tipo de reporte", context),
              SizedBox(height: 6.h),
              ListaTiposTicketWidget(
                tipos: tipos,
                selectedTipo: selectedTipo,
                onTap: onSelectTipo,
              ),

              if (mostrarClarifications) ...[
                SizedBox(height: 16.h),
                _buildSectionTitle("Categoría", context),
                SizedBox(height: 8.h),
                clarifications.isEmpty
                    ? Center(
                        child: Text(
                          "No hay categorías disponibles",
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 45.h,
                        child: ListaClarificationTypesWidget(
                          tipos: clarifications,
                          seleccionado: selectedClarification,
                          onTap: onSelectClarification,
                        ),
                      ),
              ],

              SizedBox(height: 18.h),
              _buildSectionTitle("Asunto", context),
              _buildTextInput(context, controller: subjectController),

              _buildSectionTitle("Descripción", context),
              _buildTextInput(context, controller: descriptionController, maxLines: 3),

              _buildSectionTitle("Mensaje inicial", context),
              _buildTextInput(context, controller: messageController, maxLines: 4),

              _buildSectionTitle("Archivo adjunto", context),
              _buildFilePicker(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: AppTextStyles.promoButtonText(context).copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.text(context),
        ),
      ),
    );
  }

Widget _buildTextInput(
  BuildContext context, {
  required TextEditingController controller,
  int maxLines = 1,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: maxLines == 1 ? TextInputType.text : TextInputType.multiline,
      style: AppTextStyles.bodySmall(context).copyWith(
        fontSize: 13.sp,
        color: AppColors.text(context),
      ),
      decoration: InputDecoration(
        hintText: maxLines == 1 ? "Escribe aquí..." : "Agrega más detalles...",
        hintStyle: AppTextStyles.inputHint(context).copyWith(
          fontSize: 12.sp,
          color: AppColors.text(context).withOpacity(0.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        filled: true,
        fillColor: AppColors.inputBackground2(context),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.inputBorder(context), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.cardtextfondo(context), width: 1.3),
        ),
      ),
    ),
  );
}


Widget _buildFilePicker(BuildContext context) {
  return GestureDetector(
    onTap: onPickFile,
    child: DottedBorder(
      color: AppColors.inputBorder(context),
      strokeWidth: 1,
      dashPattern: [6, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.inputBackground1(context), // ✅ se adapta al tema
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 28.sp,
              color: AppColors.text(context).withOpacity(0.5), // ✅ más tenue
            ),
            SizedBox(height: 10.h),
            Text(
              "Selecciona archivo desde tu dispositivo",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(context).copyWith(
                fontSize: 12.sp,
                color: AppColors.text(context).withOpacity(0.6), // ✅ mejor contraste
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.cardtextfondo(context), // ✅ color institucional
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 18.sp),
            ),
            if (fileName != null) ...[
              SizedBox(height: 12.h),
              Text(
                fileName!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cardtextfondo(context),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

}
