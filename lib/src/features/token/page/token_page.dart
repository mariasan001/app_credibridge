import 'package:app_creditos/src/features/token/widget/otp_input.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/features/registro/widgets/numero_servidor_field.dart';
import 'package:app_creditos/src/features/registro/services/registro_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  bool showContainer = false;

  @override
  void initState() {
    super.initState();
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: logoTop,
            left: 0,
            right: 0,
            child: const Center(child: LogoTitle()),
          ),
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
              child: const _TokenBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TokenBody extends StatefulWidget {
  const _TokenBody();

  @override
  State<_TokenBody> createState() => _TokenBodyState();
}

class _TokenBodyState extends State<_TokenBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  bool _isLoading = false;

  void _buscarServidor() async {
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
        await const FlutterSecureStorage().write(
          key: 'registro_userId',
          value: userId,
        );

        if (!mounted) return;
        Navigator.pushNamed(context, '/token');
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
            titlePrefix: '¡Te Encontramos!',
            titleHighlight: '',
            titleSuffix: '',
            subtitle:
                'te enviaremos un token de verifación por seguridad este token se mandara a tu numero telefónico registrado ',
          ),
          const SizedBox(height: 42),
          OtpInput(
            onCompleted: (code) {
              print('Código ingresado: $code');
              // Aquí puedes hacer validación o enviar el token
            },
          ),

          const SizedBox(height: 64),
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
