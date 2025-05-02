import 'package:flutter/material.dart';

class OtpInput extends StatefulWidget {
  final void Function(String) onCompleted;

  const OtpInput({super.key, required this.onCompleted});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
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

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6 && !code.contains('')) {
      widget.onCompleted(code);
    }
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
            onChanged: (value) => _onChanged(value, i),
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          ),
        );
      }),
    );
  }
}
