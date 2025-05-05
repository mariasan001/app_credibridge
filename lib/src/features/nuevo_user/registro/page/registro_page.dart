// FLUTTER
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// THEME & WIDGETS COMPARTIDOS
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';

// COMPONENTES DE REGISTRO
import 'package:app_creditos/src/features/nuevo_user/registro/widgets/numero_servidor_field.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/services/registro_service.dart';

/// Página principal del registro de nuevos usuarios
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool showContainer = false;

  @override
  void initState() {
    super.initState();
    // Activa la animación del contenedor al entrar
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 300;

    final horizontalPadding = isTablet ? 70.0 : 24.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop =
        showContainer
            ? (isKeyboardVisible ? 250.0 : (isTablet ? 450.0 : 180.0))
            : 50.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Logo con animación de entrada superior
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),
          // Contenedor animado inferior con formulario
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
              child: const _RegistroBody(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contenido del formulario de registro
class _RegistroBody extends StatefulWidget {
  const _RegistroBody();

  @override
  State<_RegistroBody> createState() => _RegistroBodyState();
}

class _RegistroBodyState extends State<_RegistroBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  bool _isLoading = false;

  /// Verifica si el número de servidor existe, y si sí, navega a la siguiente pantalla
  Future<void> _buscarServidor() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = _numeroController.text.trim();
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa tu número de servidor'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final existe = await RegistroService.validarServidor(userId);

      if (existe) {
        // Guardamos el ID del servidor temporalmente para usarlo más adelante
        await const FlutterSecureStorage().write(
          key: 'registro_userId',
          value: userId,
        );

        if (!mounted) return;
        Navigator.pushNamed(context, '/correo');
      }
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
            titlePrefix: 'Empieza tu',
            titleHighlight: 'Registro',
            titleSuffix: 'aqui', 
            subtitle: 'Ingresa tu número de servidor público para continuar.',
          ),

          const SizedBox(height: 12),
          NumeroServidorField(controller: _numeroController),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Enviar',
              isLoading: _isLoading,
              onPressed: _buscarServidor,
            ),
          ),
          const SizedBox(height: 24),
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
