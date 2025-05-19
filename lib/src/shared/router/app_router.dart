import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/nuevo_user/correo/page/correo_page.dart';
import 'package:app_creditos/src/features/nuevo_user/registro/page/registro_page.dart';
import 'package:app_creditos/src/features/nuevo_user/token/page/token_page.dart';
import 'package:app_creditos/src/features/recuperar_pasword/correo/page/correo_page.dart' as recuperar;
import 'package:app_creditos/src/features/recuperar_pasword/token/page/token_recuperar_page.dart';

class AppRouter {
  static final routes = <String, WidgetBuilder>{
    '/login': (_) => const LoginPage(),
    '/registro': (_) => const RegistroPage(),
    '/correo': (_) => const CorreoPage(),
    '/token': (_) => const TokenPage(),
    '/Rcorreo': (_) => const recuperar.RcorreoPage(),
    '/token_recuperar': (_) => const TokenRecuperarPage(),
  };
}
