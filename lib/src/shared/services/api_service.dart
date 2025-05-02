import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Enum que define los entornos disponibles
enum Environment { casa, oficina, prod }

class ApiService {
  /// Selecciona aquí tu entorno actual
  static const Environment currentEnv = Environment.casa;

  /// Retorna el baseUrl según el entorno actual
  static String _getBaseUrl() {
    switch (currentEnv) {
      case Environment.casa:
        return 'http://192.168.100.183:2910'; // Cambia por tu IP local en casa
      case Environment.oficina:
        return 'http://10.0.32.117:2910'; // IP del backend en oficina
      case Environment.prod:
        return 'https://api.credibridge.com'; // Producción
    }
  }

  /// Dio se define como `late` para poder reemplazarlo en tests si es necesario
  static late Dio _dio;

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Inicializa Dio con configuración base y token interceptor
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
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

  /// Acceso global a Dio
  static Dio get dio => _dio;

  /// Permite reemplazar Dio (útil para tests)
  static set dio(Dio client) => _dio = client;
}
