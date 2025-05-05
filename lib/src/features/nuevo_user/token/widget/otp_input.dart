import 'package:flutter/material.dart';

/// Widget para ingresar un código de 6 caracteres alfanuméricos.
/// Cada carácter se ingresa en un campo separado y se notifica cuando se completa.
class OtpInput extends StatefulWidget {
  final void Function(String) onCompleted;

  const OtpInput({super.key, required this.onCompleted});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  // Lista de controladores y focusNodes para los 6 campos
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Maneja el cambio en cada campo individual
  void _onChanged(String value, int index) {
    // Validar que solo se permita un carácter alfanumérico
    if (!RegExp(r'^[a-zA-Z0-9]?$').hasMatch(value)) {
      _controllers[index].clear();
      return;
    }

    // Avanzar automáticamente al siguiente campo si no es el último
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    // Construir el código completo
    final code = _controllers.map((c) => c.text).join();

    // Notificar a la página padre
    widget.onCompleted(code);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (i) {
        return Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.teal, width: 2),
              ),
            ),
            onChanged: (value) {
              // Convertir cualquier entrada a mayúsculas
              final uppercaseValue = value.toUpperCase();
              _controllers[i].value = TextEditingValue(
                text: uppercaseValue,
                selection: TextSelection.collapsed(offset: uppercaseValue.length),
              );
              _onChanged(uppercaseValue, i);
            },
          ),
        );
      }),
    );
  }
}
