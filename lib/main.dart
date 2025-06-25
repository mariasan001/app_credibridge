import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/features/splash/page/preloader_screen.dart';
import 'src/shared/services/api_service.dart';
import 'src/shared/theme/theme_notifier.dart';
import 'src/shared/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX', null);
  ApiService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const AppWrapper(),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'CrediBridge App',
          debugShowCheckedModeBanner: false, 
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: const Color(0xFFF5F5F7),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF944D)),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: themeNotifier.currentTheme,
          home: const PreloaderCAnimated(),
          routes: AppRouter.routes, 
        );
      },
    );
  }
}
