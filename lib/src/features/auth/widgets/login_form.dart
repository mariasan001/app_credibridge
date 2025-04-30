import 'package:app_creditos/src/features/auth/services/auth_service.dart';
import 'package:app_creditos/src/features/auth/widgets/form_fields.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Estado del botón y visibilidad de contraseña
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Función que maneja el envío del formulario
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await AuthService.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    // Verifica que el widget siga montado en el árbol
    if (!mounted) return;

    setState(() => _isLoading = false);

    // Redirección si el login fue exitoso
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login exitoso')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(user: result.user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de texto para el número de servidor
          UsernameField(controller: _usernameController),

          const SizedBox(height: 46),

          // Campo de texto para la contraseña
          _buildPasswordField(),

          const SizedBox(height: 8),

          // Enlace para recuperar contraseña
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Aquí puedes agregar la navegación al recovery
              },
              child: Text(
                'Olvidé mi contraseña',
                style: AppTextStyles.linkMuted,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Botón de envío
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.buttonForeground,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: AppTextStyles.buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.buttonForeground,
                  )
                : const Text('Ingresar'),
          ),

          const SizedBox(height: 16),

          // Enlace para registrarse
          Center(
            child: TextButton(
              onPressed: () {
                // Aquí podrías abrir una pantalla de registro
              },
              child: Text(
                'Quiero registrarme',
                style: AppTextStyles.linkBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método privado para construir el campo de contraseña con visibilidad toggle
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Contraseña *',
        hintText: 'Escribe tu contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel,
        hintStyle: AppTextStyles.inputHint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () =>
              setState(() => _obscurePassword = !_obscurePassword),
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
      validator: (value) => value == null || value.isEmpty
          ? 'Por favor ingresa tu contraseña'
          : null,
    );
  }
}
