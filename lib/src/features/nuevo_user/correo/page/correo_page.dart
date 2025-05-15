import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Features
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/features/nuevo_user/correo/service/registro_service.dart';
import 'package:app_creditos/src/features/nuevo_user/correo/widget/correofield.dart';

// Shared
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

/// Página donde el usuario debe ingresar su correo para recibir un token de verificación
class CorreoPage extends StatefulWidget {
  const CorreoPage({super.key});

  @override
  State<CorreoPage> createState() => _CorreoPageState();
}

class _CorreoPageState extends State<CorreoPage> {
  bool showContainer = false;

  @override
  void initState() {
    super.initState();

    // Activamos la animación de entrada del formulario
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet ? 70.0 : 14.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop =
        showContainer
            ? (isKeyboardVisible ? 250.0 : (isTablet ? 450.0 : 180.0))
            : 50.0;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Stack(
        children: [
          // Logo institucional con animación
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),

          // Contenedor con el formulario
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: showContainer ? 0 : -600,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: const _CorreoBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CorreoBody extends StatefulWidget {
  const _CorreoBody();

  @override
  State<_CorreoBody> createState() => _CorreoBodyState();
}

class _CorreoBodyState extends State<_CorreoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  bool _isLoading = false;

  /// Función que valida el formulario y envía el token por correo
  void _enviarToken() async {
    if (!_formKey.currentState!.validate()) return;

    final correo = _correoController.text.trim();
    setState(() => _isLoading = true);

    try {
      // Recuperamos el número de servidor previamente almacenado
      final userId = await const FlutterSecureStorage().read(
        key: 'registro_userId',
      );

      if (userId == null || userId.isEmpty) {
        throw 'No se encontró el número de servidor.';
      }

      // Enviamos el token al correo del usuario
      await CorreoService.enviarTokenPorCorreo(userId: userId, email: correo);

      if (!mounted) return;

      // Navegamos a la pantalla para validar el token
      Navigator.pushNamed(context, '/token');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const WelcomeText(
            titlePrefix: '¡Te encontramos!',
            titleHighlight: '',
            titleSuffix: '',
            subtitle:
                'Por seguridad, enviaremos un token de verificación a tu correo electrónico.',
          ),
          const SizedBox(height: 32),

          // Campo de correo electrónico
          CorreoField(controller: _correoController),

          const SizedBox(height: 64),

          // Botón para enviar token
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Enviar',
              isLoading: _isLoading,
              onPressed: _enviarToken,
            ),
          ),

          const SizedBox(height: 24),

          // Aviso de privacidad
          Center(
            child: Text(
              'Aviso de privacidad',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
