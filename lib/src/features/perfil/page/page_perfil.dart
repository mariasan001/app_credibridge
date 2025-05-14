import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget buildField(IconData icon, String label, String value, {bool enabled = false}) {
    final isStatusField = label == 'Situación';
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isStatusField && value.toLowerCase().contains('activa'))
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 16),
          ...fields,
        ],
      ),
    );
  }

  Widget buildSkeletonSection() {
    Widget shimmerLine({double width = double.infinity}) => Container(
      height: 14,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );

    Widget shimmerField() => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: Colors.grey[300]),
          const SizedBox(width: 12),
          Expanded(child: Column(children: [shimmerLine(width: 100), shimmerLine()]))
        ],
      ),
    );

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(4, (_) => buildSection("", List.generate(4, (_) => shimmerField()))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F2),
      appBar: CustomAppBar(user: user),
      body: _isLoading
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: buildSkeletonSection(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text('Mi perfil', style: AppTextStyles.heading(context)),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _isEditing
                              ? const Color.fromARGB(255, 6, 110, 69)
                              : const Color.fromARGB(255, 17, 27, 93),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(_isEditing ? 'Guardar' : 'Actualizar información'),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Consulta y edita tus datos', style: AppTextStyles.bodySmall(context)),
                  const SizedBox(height: 24),

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
