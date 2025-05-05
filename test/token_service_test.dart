import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';

// 👇 Esta línea genera el mock automáticamente
@GenerateMocks([Dio])
import 'token_service_test.mocks.dart';

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    ApiService.dio = mockDio;
  });

  test('✅ Verifica token exitosamente con status 200', () async {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
    )).thenAnswer(
      (_) async => Response(
        statusCode: 200,
        data: {},
        requestOptions: RequestOptions(path: '/auth/reset-password'),
      ),
    );

    await expectLater(
      TokenService.verificarToken(
        code: 'ABC123',
        newPassword: 'temporal123',
      ),
      completes,
    );
  });

  test('❌ Token inválido retorna mensaje esperado', () async {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
    )).thenThrow(DioException(
      requestOptions: RequestOptions(path: '/auth/reset-password'),
      response: Response(
        statusCode: 404,
        data: {'message': 'Código inválido o expirado.'},
        requestOptions: RequestOptions(path: '/auth/reset-password'),
      ),
      type: DioExceptionType.badResponse,
    ));

    await expectLater(
      () => TokenService.verificarToken(
        code: 'WRONG',
        newPassword: 'temporal123',
      ),
      throwsA('Código inválido o expirado.'),
    );
  });

  test('🚨 Error inesperado captura fallback', () async {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
    )).thenThrow(Exception('Unknown'));

    await expectLater(
      () => TokenService.verificarToken(
        code: 'ERROR',
        newPassword: 'temporal123',
      ),
      throwsA('Error inesperado al validar el token.'),
    );
  });
}
