// lib/main.dart
import 'package:app_creditos/src/features/splash/page/preloader_screen.dart';
import 'package:flutter/material.dart';
import 'src/shared/services/api_service.dart';
import 'src/features/auth/page/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.init(); // Inicializar interceptores
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
       textTheme: GoogleFonts.poppinsTextTheme(), // 👈 Aquí se aplica globalmente
        scaffoldBackgroundColor: const Color(0xFFFCF8F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF944D)),
        useMaterial3: true,
      ),
      // 👇 Mostramos primero la pantalla del preloader
     home: const PreloaderCAnimated(),

      // 👇 Definimos las rutas si las quieres usar
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
