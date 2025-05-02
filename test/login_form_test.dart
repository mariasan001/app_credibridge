import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_creditos/src/features/auth/widgets/login_form.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginForm UI tests', () {
    testWidgets('Renderiza los campos de usuario y contraseña', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: LoginForm()),
      ));

      expect(find.text('Número de Servidor público *'), findsOneWidget);
      expect(find.text('Contraseña *'), findsOneWidget);
      expect(find.text('Enviar'), findsOneWidget);
    });

    testWidgets('Muestra error si campos están vacíos al enviar', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: LoginForm()),
      ));

      await tester.tap(find.text('Enviar'));
      await tester.pump();

      expect(find.text('Por favor ingresa tu número de servidor'), findsOneWidget);
      expect(find.text('Por favor ingresa tu contraseña'), findsOneWidget);
    });
  });
}
