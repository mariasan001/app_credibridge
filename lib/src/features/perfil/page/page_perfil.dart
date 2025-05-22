import 'package:app_creditos/src/features/perfil/page/perfil_skeleton.dart';
import 'package:app_creditos/src/features/perfil/services/contacto_local_storage.dart';
import 'package:app_creditos/src/features/perfil/services/user_contact_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/perfil/widget/perfil_field.dart';
import 'package:app_creditos/src/features/perfil/widget/perfil_section.dart';

class PerfilPage extends StatefulWidget {
  final User user;

  const PerfilPage({super.key, required this.user});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}
class _PerfilPageState extends State<PerfilPage> {
  bool _isEditing = false;
  bool _isLoading = true;

  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  late User _user; // ✅ usuario local

  @override
  void initState() {
    super.initState();
    _user = widget.user; // ✅ lo guardamos localmente

    _emailController = TextEditingController(text: _user.email ?? '');
    _phoneController = TextEditingController(text: _user.phone ?? '');

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagePadding = MediaQuery.of(context).size.width > 600 ? 20.w : 16.w;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: _user),
      body: _isLoading
          ? const PerfilSkeleton()
          : ListView(
              padding: EdgeInsets.all(pagePadding),
              physics: const BouncingScrollPhysics(),
              children: [
                // Header
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
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: TextButton(
                        key: ValueKey(_isEditing),
                        onPressed: () async {
                          if (_isEditing) {
                            try {
                              final nuevoEmail = _emailController.text;
                              final nuevoPhone = _phoneController.text;

                              await ContactService.actualizarContacto(
                                userId: _user.userId,
                                email: nuevoEmail,
                                phone: nuevoPhone,
                              );

                              await ContactoLocalStorage.guardar(nuevoEmail, nuevoPhone);

                              setState(() {
                                _user = _user.copyWith(
                                  email: nuevoEmail,
                                  phone: nuevoPhone,
                                );
                                _isEditing = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Contacto actualizado con éxito')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al actualizar: $e')),
                              );
                            }
                          } else {
                            setState(() => _isEditing = true);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _isEditing ? Colors.green : AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text(_isEditing ? 'Guardar' : 'Editar'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Datos personales
                PerfilSection(
                  title: "Datos Personales",
                  children: [
                    PerfilField(icon: Icons.person, label: 'Nombre completo', value: _user.name),
                    PerfilField(icon: Icons.perm_identity, label: 'CURP', value: _user.curp ?? ''),
                    PerfilField(icon: Icons.fingerprint, label: 'RFC', value: _user.rfc ?? ''),
                    PerfilField(icon: Icons.badge, label: 'Número de Servidor Público', value: _user.userId),
                  ],
                ),

                // Contacto editable
                PerfilSection(
                  title: "Contacto",
                  children: [
                    PerfilField(
                      icon: Icons.email,
                      label: 'Correo electrónico',
                      value: _user.email ?? '',
                      controller: _emailController,
                      isEditing: _isEditing,
                      editable: true,
                    ),
                    PerfilField(
                      icon: Icons.phone,
                      label: 'Teléfono',
                      value: _user.phone ?? '',
                      controller: _phoneController,
                      isEditing: _isEditing,
                      editable: true,
                    ),
                  ],
                ),

                // Datos laborales
                PerfilSection(
                  title: "Datos Laborales",
                  children: [
                    PerfilField(icon: Icons.apartment, label: 'Dependencia', value: _user.workUnit?.desc ?? ''),
                    PerfilField(icon: Icons.credit_card, label: 'Nómina', value: _user.bank?.desc ?? ''),
                    PerfilField(icon: Icons.work_outline, label: 'Puesto', value: _user.jobCode?.desc ?? ''),
                    PerfilField(icon: Icons.date_range, label: 'Fecha de ocupación', value: _user.occupationDate ?? ''),
                    PerfilField(icon: Icons.verified, label: 'Situación', value: _user.positionStatus?.desc ?? ''),
                    PerfilField(icon: Icons.security, label: 'Estatus de usuario', value: _user.userStatus?.desc ?? ''),
                  ],
                ),

                // Roles
                if (!_isEditing)
                  PerfilSection(
                    title: "Roles",
                    children: _user.roles.isNotEmpty
                        ? _user.roles.map((rol) {
                            return PerfilField(
                              icon: Icons.check_circle_outline,
                              label: 'Rol asignado',
                              value: rol.description,
                            );
                          }).toList()
                        : [
                            PerfilField(
                              icon: Icons.info_outline,
                              label: 'Rol asignado',
                              value: 'Sin rol',
                            ),
                          ],
                  ),
              ],
            ),
    );
  }
}
