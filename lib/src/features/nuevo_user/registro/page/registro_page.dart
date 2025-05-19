import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/components/login_button.dart';
import 'package:app_creditos/src/shared/components/welcome_text.dart';
import 'package:app_creditos/src/features/auth/widgets/logo_title.dart';

import 'package:app_creditos/src/features/nuevo_user/registro/widgets/numero_servidor_field.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/model/servidor_publico_request.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/services/registro_service.dart';

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
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => showContainer = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final double logoTop = showContainer
        ? (isKeyboardVisible ? 120.h : 120.h)
        : 60.h;

    return Scaffold(
      backgroundColor: AppColors.background(context),
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
            bottom: showContainer ? 0 : -600.h,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: const _RegistroBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegistroBody extends StatefulWidget {
  const _RegistroBody();

  @override
  State<_RegistroBody> createState() => _RegistroBodyState();
}

class _RegistroBodyState extends State<_RegistroBody> {
  final _formKey = GlobalKey<FormState>();

  final _numeroController = TextEditingController();
  final _plazaController = TextEditingController();
  final _jobCodeController = TextEditingController();
  final _rfcController = TextEditingController();

  bool _isLoading = false;

  Future<void> _buscarServidor() async {
    if (!_formKey.currentState!.validate()) return;

    final request = ServidorPublicoRequest(
      userId: _numeroController.text.trim(),
      plaza: _plazaController.text.trim(),
      jobCode: _jobCodeController.text.trim(),
      rfc: _rfcController.text.trim(),
    );

    setState(() => _isLoading = true);

    try {
      final existe = await RegistroService.validarServidor(request);

      if (existe) {
        await const FlutterSecureStorage().write(
          key: 'registro_userId',
          value: request.userId,
        );

        if (!mounted) return;
        Navigator.pushNamed(context, '/correo');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
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
            titleSuffix: 'aquí',
            subtitle: 'Ingresa tus datos laborales para continuar.',
          ),
          SizedBox(height: 24.h),
          NumeroServidorField(controller: _numeroController),
          SizedBox(height: 16.h),
          PlazaField(controller: _plazaController),
          SizedBox(height: 16.h),
          JobCodeField(controller: _jobCodeController),
          SizedBox(height: 16.h),
          RfcField(controller: _rfcController),
          SizedBox(height: 28.h),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Enviar',
              isLoading: _isLoading,
              onPressed: _buscarServidor,
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Text(
              'Aviso de privacidad',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
