import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_creditos/src/features/auth/services/auth_service.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

import 'auth_service_test.mocks.dart'; // generado por build_runner

@GenerateMocks([Dio, FlutterSecureStorage])
void main() {
  group('AuthService', () {
    late MockDio mockDio;
    late MockFlutterSecureStorage mockStorage;

    setUp(() {
      mockDio = MockDio();
      mockStorage = MockFlutterSecureStorage();

      ApiService.dio = mockDio;
      AuthService.setStorageForTest(mockStorage);
    });

    test('Login exitoso devuelve User', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 200,
        data: {
          'user': {
            'userId': '123',
            'name': 'Usuario de prueba',
            'email': 'test@example.com',
            'roles': [
              {'id': 1, 'description': 'admin'},
            ],
          }
        },
        headers: Headers.fromMap({
          'set-cookie': ['JWT=fakeToken123; Path=/; HttpOnly']
        }),
      );

      when(
        mockDio.post(any, data: anyNamed('data')),
      ).thenAnswer((_) async => mockResponse);

      when(
        mockStorage.write(key: anyNamed('key'), value: anyNamed('value')),
      ).thenAnswer((_) async => null);

      final result = await AuthService.login('test', '1234');

      expect(result, isA<User>());
      expect(result?.name, equals('Usuario de prueba'));
      expect(result?.userId, equals('123'));
    });

    test('Login fallido devuelve error del backend', () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 403,
        data: {'message': 'Credenciales inválidas'},
      );

      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => AuthService.login('baduser', 'wrongpass'),
        throwsA(predicate((e) => e.toString().contains('Credenciales inválidas'))),
      );
    });

    test('getProfile devuelve objeto User con datos válidos', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/auth/profile'),
        statusCode: 200,
        data: {
          'userId': '456',
          'name': 'Perfil de prueba',
          'email': 'perfil@example.com',
          'roles': [
            {'id': 2, 'description': 'editor'},
          ],
        },
      );

      when(mockDio.get('/auth/profile')).thenAnswer((_) async => mockResponse);

      final user = await AuthService.getProfile();

      expect(user, isA<User>());
      expect(user?.userId, equals('456'));
      expect(user?.name, equals('Perfil de prueba'));
      expect(user?.roles.first.description, equals('editor'));
    });

    test('Login con error inesperado lanza mensaje genérico', () async {
      when(
        mockDio.post(any, data: anyNamed('data')),
      ).thenThrow(Exception('Fallo de red'));

      expect(
        () => AuthService.login('test', '1234'),
        throwsA(predicate((e) => e.toString().contains('Error inesperado'))),
      );
    });
  });
}
