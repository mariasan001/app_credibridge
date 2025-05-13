import 'package:app_creditos/src/shared/components/alertas.dart';
import 'package:flutter/material.dart';
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
        builder: (context) => HomePage(user: result), // ✅ Cambio clave aquí
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
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    final double fieldSpacing = isTablet ? 46 : 32;
    final double bottomSpacing = isTablet ? 16 : 12;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UsernameField(controller: _usernameController),

          SizedBox(height: fieldSpacing),

          buildPasswordField(),

          const SizedBox(height: 8),

          const RecoveryLink(),

          SizedBox(height: bottomSpacing),

          PrimaryButton(
            label: 'Enviar',
            isLoading: _isLoading,
            onPressed: _submit,
          ),

          SizedBox(height: bottomSpacing),

          const RegisterLink(),
        ],
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Contraseña *',
        hintText: 'Escribe tu contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context),
        hintStyle: AppTextStyles.inputHint(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator:
          (value) =>
              value == null || value.isEmpty
                  ? 'Por favor ingresa tu contraseña'
                  : null,
    );
  }
}
