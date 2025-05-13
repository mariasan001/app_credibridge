// Flutter
import 'package:flutter/material.dart';


//Imports del proyecto
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/features/nuevo_user/pass_new_user/page/pass_new_user.dart';
import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';
import 'package:app_creditos/src/features/nuevo_user/token/widget/otp_input.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';


/// Pantalla donde el usuario ingresa el código que recibió por correo.
/// Esta validación es necesaria antes de permitirle crear una contraseña nueva.
class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  bool showContainer = false; // Controla la animación de aparición del contenedor inferior
  bool _isLoading = false;    // Indica si se está procesando la validación del token
  String _codigoIngresado = ''; // Almacena el código ingresado por el usuario

  @override
  void initState() {
    super.initState();
    // Espera 400ms antes de mostrar la sección inferior con animación
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  /// Función que valida el token ingresado por el usuario.
  /// Si es válido, se redirige a la página de creación de contraseña.
  void _validarToken() async {
    const String passwordTemporal = 'temporal123'; // Contraseña temporal que exige el backend

    if (_codigoIngresado.isEmpty || _codigoIngresado.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un código válido')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Llamada al servicio que valida el token en el backend
      await TokenService.verificarToken(
        code: _codigoIngresado,
        newPassword: passwordTemporal,
      );

      // Si todo salió bien, navegamos a la pantalla para crear contraseña
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ContrasenaPage(code: _codigoIngresado),
        ),
      );
    } catch (e) {
      // En caso de error (token incorrecto, expirado, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 300;

    final horizontalPadding = isTablet ? 70.0 : 24.0;
    final verticalPadding = isTablet ? 72.0 : 48.0;
    final double logoTop =
        showContainer ? (isKeyboardVisible ? 190.0 : (isTablet ? 350.0 : 180.0)) : 50.0;

    return Scaffold(
      backgroundColor:AppColors.background(context),
      body: Stack(
        children: [
          // Logo animado que se posiciona según teclado/pantalla
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),
          // Contenedor inferior que aparece con animación
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Texto de bienvenida e instrucciones
                  const WelcomeText(
                    titlePrefix: 'Revisa tu',
                    titleHighlight: 'correo electrónico',
                    titleSuffix: 'e ingresa tu código',
                    subtitle:
                        'Te enviamos un token de verificación. Por seguridad, este token fue enviado a tu correo registrado.',
                  ),
                  const SizedBox(height: 42),

                  // Campo OTP para ingresar los 6 dígitos del código
                  OtpInput(
                    onCompleted: (code) {
                      setState(() {
                        _codigoIngresado = code;
                      });
                    },
                  ),

                  const SizedBox(height: 64),

                  // Botón para validar el token ingresado
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Validar Token',
                      isLoading: _isLoading,
                      onPressed: _validarToken,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Texto de aviso legal
                  Center(
                    child: Text(
                      'Aviso de privacidad',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
