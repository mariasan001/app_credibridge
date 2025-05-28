import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/lender_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_cat.model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_create_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/historial_solicitudes_page.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/lender_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/ticket_type_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/ticket_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/tiket_cat_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/ticket_form_widget.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportePaso1FinancieraPage extends StatefulWidget {
  final User user;

  const ReportePaso1FinancieraPage({super.key, required this.user});

  @override
  State<ReportePaso1FinancieraPage> createState() =>
      _ReportePaso1FinancieraPageState();
}

class _ReportePaso1FinancieraPageState
    extends State<ReportePaso1FinancieraPage> {
  late Future<List<LenderModel>> _financierasFuture;
  late Future<List<TicketTypeModel>> _tiposFuture;

  LenderModel? _lenderSeleccionado;
  TicketTypeModel? _tipoSeleccionado;
  ClarificationTypeModel? _clarificationSeleccionado;
  List<ClarificationTypeModel> _clarifications = [];

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final messageController = TextEditingController();

  String? _archivoNombre;
  String? _archivoPath;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _financierasFuture = LenderService.getLendersByUser(widget.user.userId);
    _tiposFuture = TicketTypeService.getAllTicketTypes();
  }

  void _seleccionarArchivo() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _archivoNombre = result.files.single.name;
        _archivoPath = result.files.single.path;
      });
    }
  }

  Future<void> _enviarTicket() async {
    if (_isSubmitting) return;

    if (_lenderSeleccionado == null ||
        _tipoSeleccionado == null ||
        (_tipoSeleccionado?.ticketTypeDesc.toLowerCase() == 'solicitud' &&
            _clarificationSeleccionado == null))
      return;

    final ticket = TicketCreateModel(
      userId: widget.user.userId,
      subject: subjectController.text.trim(),
      description: descriptionController.text.trim(),
      ticketTypeId: _tipoSeleccionado!.id,
      lenderId: _lenderSeleccionado!.id,
      clarificationType:
       _tipoSeleccionado?.ticketTypeDesc.toLowerCase() == 'solicitud'
      ? _clarificationSeleccionado?.id
      : null,

      initialMessage: messageController.text.trim(),
    );

    setState(() => _isSubmitting = true);

    try {
      final response = await TicketService.createTicket(
        ticket,
        filePath: _archivoPath,
        fileName: _archivoNombre,
      );

      if (!mounted) return;

      // ✅ ALERTA MODERNA DE ÉXITO
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Tu solicitud fue enviada con éxito.',
                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          duration: const Duration(seconds: 2),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      );

      // Esperar a que se muestre el snackbar antes de navegar
      await Future.delayed(const Duration(milliseconds: 500));

      // Navegar al historial de solicitudes
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HistorialSolicitudesPage(user: widget.user),
          ),
        );
      }

      // Limpiar estado tras éxito
      setState(() {
        _lenderSeleccionado = null;
        _tipoSeleccionado = null;
        _clarificationSeleccionado = null;
        _clarifications = [];
        _archivoNombre = null;
        _archivoPath = null;
        subjectController.clear();
        descriptionController.clear();
        messageController.clear();
      });
    } catch (e) {
      // ❌ ALERTA MODERNA DE ERROR
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Error al enviar la solicitud.',
                  style: TextStyle(fontSize: 13.sp),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          duration: const Duration(seconds: 4),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _cargarClarificacionesSiEsSolicitud(TicketTypeModel tipo) async {
    if (tipo.ticketTypeDesc.toLowerCase() == 'solicitud') {
      try {
        final data = await ClarificationTypeService.getAllClarificationTypes();
        setState(() => _clarifications = data);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Error al cargar categorías: $e")),
        );
      }
    } else {
      setState(() => _clarifications = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([_financierasFuture, _tiposFuture]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final List<LenderModel> financieras = snapshot.data![0];
          final List<TicketTypeModel> tipos = snapshot.data![1];

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TicketFormWidget(
                  financieras: financieras,
                  selectedLender: _lenderSeleccionado,
                  onSelectLender:
                      (lender) => setState(() => _lenderSeleccionado = lender),
                  tipos: tipos,
                  selectedTipo: _tipoSeleccionado,
                  onSelectTipo: (tipo) {
                    setState(() {
                      _tipoSeleccionado = tipo;
                      _clarificationSeleccionado = null;
                    });
                    _cargarClarificacionesSiEsSolicitud(tipo);
                  },
                  mostrarClarifications:
                      _tipoSeleccionado?.ticketTypeDesc.toLowerCase() ==
                      "solicitud",
                  clarifications: _clarifications,
                  selectedClarification: _clarificationSeleccionado,
                  onSelectClarification:
                      (clarification) => setState(
                        () => _clarificationSeleccionado = clarification,
                      ),
                  subjectController: subjectController,
                  descriptionController: descriptionController,
                  messageController: messageController,
                  onPickFile: _seleccionarArchivo,
                  fileName: _archivoNombre,
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        (_lenderSeleccionado != null &&
                                _tipoSeleccionado != null &&
                                (_tipoSeleccionado?.ticketTypeDesc
                                            .toLowerCase() !=
                                        "solicitud" ||
                                    _clarificationSeleccionado != null) &&
                                !_isSubmitting)
                            ? _enviarTicket
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                    child:
                        _isSubmitting
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18.sp,
                                  height: 18.sp,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  "Enviando solicitud...",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                            : Text(
                              "Enviar solicitud",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
