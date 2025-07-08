import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class RateServiceScreen extends StatefulWidget {
  const RateServiceScreen({super.key});

  @override
  State<RateServiceScreen> createState() => _RateServiceScreenState();
}

class _RateServiceScreenState extends State<RateServiceScreen> {
  int _rating = 0;
  final _commentController = TextEditingController();
  String _selectedConsultant = '';
  final List<String> _consultants = [
    'Carlos Ramírez',
    'Lucía Torres',
    'Pedro Gómez',
  ];

  void _submitRating(String lang) {
    if (_rating == 0 || _selectedConsultant.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              lang == 'es'
                  ? 'Selecciona consultor y calificación'
                  : 'Select consultant and rating'),
        ),
      );
      return;
    }

    final comment = _commentController.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          lang == 'es'
              ? 'Has calificado a $_selectedConsultant con $_rating ⭐\nComentario: ${comment.isEmpty ? "Ninguno" : comment}'
              : 'You rated $_selectedConsultant with $_rating ⭐\nComment: ${comment.isEmpty ? "None" : comment}',
        ),
      ),
    );

    Navigator.pop(context);
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final star = index + 1;
        return IconButton(
          icon: Icon(
            star <= _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => setState(() => _rating = star),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Calificar Servicio' : 'Rate Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Consultor a calificar'
                    : 'Consultant to rate',
                border: const OutlineInputBorder(),
              ),
              items: _consultants
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => _selectedConsultant = value ?? ''),
            ),
            const SizedBox(height: 24),
            Text(
              lang == 'es' ? 'Calificación:' : 'Rating:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildStars(),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Comentario (opcional)'
                    : 'Comment (optional)',
                border: const OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(lang == 'es'
                    ? 'Enviar calificación'
                    : 'Submit rating'),
                onPressed: () => _submitRating(lang),
              ),
            ),
          ],
        ),
      ),
    );
  }
}