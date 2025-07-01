import 'package:flutter/material.dart';

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

  void _submitRating() {
    if (_rating == 0 || _selectedConsultant.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona consultor y calificación')),
      );
      return;
    }

    final comment = _commentController.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Has calificado a $_selectedConsultant con $_rating ⭐\nComentario: ${comment.isEmpty ? "Ninguno" : comment}'),
      ),
    );

    // Aquí podrías enviar los datos a tu backend
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
    return Scaffold(
      appBar: AppBar(title: const Text('Calificar Servicio')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Consultor a calificar',
                border: OutlineInputBorder(),
              ),
              items: _consultants
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedConsultant = value ?? ''),
            ),
            const SizedBox(height: 24),
            const Text('Calificación:', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildStars(),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Comentario (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Enviar calificación'),
                onPressed: _submitRating,
              ),
            ),
          ],
        ),
      ),
    );
  }
}