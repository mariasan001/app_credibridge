import 'package:app_creditos/src/features/nuevo_user/correo/page/correo_page.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/page/registro_page.dart';
import 'package:app_creditos/src/features/nuevo_user/token/page/token_page.dart';
import 'package:app_creditos/src/features/recuperar_pasword/correo/page/correo_page.dart';
import 'package:app_creditos/src/features/recuperar_pasword/token/page/token_recuperar_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/features/splash/page/preloader_screen.dart';
import 'src/features/auth/page/login_page.dart';
import 'src/shared/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Necesario para bindings
  ApiService.init(); // ✅ Inicializa interceptores y token
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrediBridge App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFCF8F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF944D)),
        useMaterial3: true,
      ),
      home: const PreloaderCAnimated(),
      //home: const ContrasenaPage(code: '124134',),
      routes: {
        '/login': (context) => const LoginPage(),
        '/token': (context) => const TokenPage(),
        '/registro': (context) => const RegistroPage(),
        '/correo': (context) => const CorreoPage(), //nuevo user 
        '/Rcorreo': (context) => const RcorreoPage(), //recuperar contraseña
        '/token_recuperar': (context) => const TokenRecuperarPage(),
       
      },
    );
  }
}
