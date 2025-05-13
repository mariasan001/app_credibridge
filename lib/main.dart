import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/features/splash/page/preloader_screen.dart';
import 'src/features/auth/page/login_page.dart';
import 'src/features/nuevo_user/correo/page/correo_page.dart';
import 'src/features/nuevo_user/registro/page/registro_page.dart';
import 'src/features/nuevo_user/token/page/token_page.dart';
import 'src/features/recuperar_pasword/correo/page/correo_page.dart';
import 'src/features/recuperar_pasword/token/page/token_recuperar_page.dart';
import 'src/shared/services/api_service.dart';
import 'src/shared/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX', null);
  ApiService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const AppWrapper(), // ← usamos un wrapper
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'CrediBridge App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFFCF8F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF944D)),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.currentTheme,
      home: const PreloaderCAnimated(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/token': (context) => const TokenPage(),
        '/registro': (context) => const RegistroPage(),
        '/correo': (context) => const CorreoPage(),
        '/Rcorreo': (context) => const RcorreoPage(),
        '/token_recuperar': (context) => const TokenRecuperarPage(),
      },
    );
  }
}
