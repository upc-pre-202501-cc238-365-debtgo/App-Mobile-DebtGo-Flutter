import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class ServiceRatingScreen extends StatefulWidget {
  const ServiceRatingScreen({super.key});

  @override
  State<ServiceRatingScreen> createState() => _ServiceRatingScreenState();
}

class _ServiceRatingScreenState extends State<ServiceRatingScreen> {
  String? _selectedConsultant;
  int _rating = 0;
  final _commentController = TextEditingController();

  final List<String> _consultants = [
    'Lucía Torres',
    'Carlos Ramírez',
    'Pedro Gómez',
  ];

  void _submitRating(String lang) {
    if (_selectedConsultant == null || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Selecciona consultor y calificación'
              : 'Select consultant and rating'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(lang == 'es'
          ? 'Has calificado a $_selectedConsultant con $_rating estrellas.\nComentario: ${_commentController.text.trim()}'
          : 'You rated $_selectedConsultant with $_rating stars.\nComment: ${_commentController.text.trim()}'),
    ));

    setState(() {
      _selectedConsultant = null;
      _rating = 0;
      _commentController.clear();
    });
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = i < _rating;
        return IconButton(
          icon: Icon(
            filled ? Icons.star : Icons.star_border,
            color: filled ? Colors.amber : Colors.grey,
          ),
          onPressed: () => setState(() => _rating = i + 1),
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
              value: _selectedConsultant,
              hint: Text(lang == 'es' ? 'Selecciona consultor' : 'Select consultant'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: lang == 'es' ? 'Consultor' : 'Consultant',
              ),
              items: _consultants
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedConsultant = value),
            ),
            const SizedBox(height: 24),
            Text(
              lang == 'es' ? 'Calificación' : 'Rating',
              style: const TextStyle(fontSize: 16),
            ),
            _buildStars(),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: lang == 'es' ? 'Comentario (opcional)' : 'Comment (optional)',
                border: const OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(lang == 'es' ? 'Enviar Calificación' : 'Submit Rating'),
                onPressed: () => _submitRating(lang),
              ),
            )
          ],
        ),
      ),
    );
  }
}