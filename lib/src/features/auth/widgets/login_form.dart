import 'package:app_creditos/src/shared/components/alertas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/auth/services/auth_service.dart';
import 'package:app_creditos/src/features/auth/widgets/form_fields.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/features/auth/widgets/recovery_link.dart';
import 'package:app_creditos/src/features/auth/widgets/register_link.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final result = await AuthService.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (result == null) {
        showCustomSnackBar(context, 'Usuario o contraseña incorrectos', isError: true);
        return;
      }

      showCustomSnackBar(context, 'Inicio de sesión exitoso');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: result),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      showCustomSnackBar(context, e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UsernameField(controller: _usernameController),
          SizedBox(height: 32.h),
          buildPasswordField(),
          SizedBox(height: 8.h),
          const RecoveryLink(),
          SizedBox(height: 16.h),
          PrimaryButton(
            label: 'Enviar',
            isLoading: _isLoading,
            onPressed: _submit,
          ),
          SizedBox(height: 16.h),
          const RegisterLink(),
        ],
      ),
    );
  }

  Widget buildPasswordField() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Contraseña *',
        hintText: 'Escribe tu contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // ✅ Colores adaptativos
        labelStyle: AppTextStyles.inputLabel(context).copyWith(
          color: AppColors.text(context),
        ),
        hintStyle: AppTextStyles.inputHint(context).copyWith(
          color: AppColors.textMuted(context),
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.text(context),
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.inputBorder(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.inputBorder(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: isDark
            ? const Color(0xFF2A2A2A)
            : const Color(0xFFF9F9F9),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Por favor ingresa tu contraseña' : null,
    );
  }
}
