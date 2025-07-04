import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:dio/dio.dart';

enum Environment { casa, oficina, prod }

class ApiService {
  static const Environment currentEnv = Environment.oficina;

  static String _getBaseUrl() {
    switch (currentEnv) {
      case Environment.casa:
        return 'http://192.168.100.183:2910';   
      case Environment.oficina:
        return 'http://10.0.32.7:2910';      
      case Environment.prod:
        return 'https://api.credibridge.com';
    }
  }

  static late Dio _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
        extra: {'withCredentials': true},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SessionManager.getToken();
          if (token != null) {
            options.headers['cookie'] = 'JWT=$token'; // Cookie manual
            print('✅ JWT enviado por cookie');
          } else {
            print('⚠️ No se encontró token en el storage');
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          print('❌ DioException: ${e.response?.statusCode}');
          print('📦 Data: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  static Dio get dio => _dio;
  static set dio(Dio client) => _dio = client;

  // ✅ NUEVO: Método para cerrar sesión
  static Future<void> logout() async {
    await SessionManager.deleteToken();
    print('✅ Token eliminado. Sesión cerrada.');
  }
}
