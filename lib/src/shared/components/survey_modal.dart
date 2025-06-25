import 'package:app_creditos/src/shared/model/survey_response_model.dart';
import 'package:app_creditos/src/shared/services/survey_model.dart';
import 'package:app_creditos/src/shared/services/survey_service.dart';
import 'package:flutter/material.dart';

class SurveyModal extends StatefulWidget {
  final String userId;
  final int lenderId;

  const SurveyModal({
    super.key,
    required this.userId,
    required this.lenderId,
  });

  @override
  State<SurveyModal> createState() => _SurveyModalState();
}

class _SurveyModalState extends State<SurveyModal> {
  late Future<List<Survey>> _futureSurveys;
  final Map<int, dynamic> _responses = {};

  @override
  void initState() {
    super.initState();
    _futureSurveys = SurveyService().fetchSurveys();
  }

  Widget _buildSurveyField(Survey survey) {
    switch (survey.type) {
      case 'rating':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                survey.text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final rating = index + 1;
                  final isSelected = _responses[survey.id] == rating;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _responses[survey.id] = rating;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange.shade100
                            : const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            ['😭', '😞', '😐', '😊', '😁'][index],
                            style: TextStyle(fontSize: isSelected ? 22 : 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ['Terrible', 'Mala', 'Regular', 'Buena', 'Excelente'][index],
                            style: TextStyle(
                              fontSize: 8,
                              color: isSelected ? Colors.orange : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );

      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                survey.text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  _responses[survey.id] = value;
                },
                maxLines: 3,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Escribe tu respuesta...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  void _handleSubmit() async {
    try {
      // Convertir _responses a lista de SurveyResponse
      final respuestas = _responses.entries.map((entry) {
        final int questionId = entry.key;
        final dynamic value = entry.value;

        if (value is int) {
          // Respuesta tipo rating
          return SurveyResponse(
            questionId: questionId,
            rating: value,
            comment: '',
          );
        } else if (value is String) {
          // Respuesta tipo texto
          return SurveyResponse(
            questionId: questionId,
            rating: 0,
            comment: value,
          );
        } else {
          throw Exception("Respuesta inválida: $value");
        }
      }).toList();

      // Enviar al backend
      await SurveyService().enviarEncuesta(
        userId: widget.userId,
        lenderId: widget.lenderId,
        respuestas: respuestas,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Encuesta enviada correctamente')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error al enviar encuesta: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Encuesta de Servicio',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Survey>>(
              future: _futureSurveys,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Error al cargar encuestas: ${snapshot.error}',
                      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  );
                }

                final surveys = snapshot.data!;
                return Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: surveys.map(_buildSurveyField).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _handleSubmit,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 8, 8, 8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
