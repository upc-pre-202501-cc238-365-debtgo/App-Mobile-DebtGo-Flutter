import 'package:flutter/material.dart';

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

  void _submitRating() {
    if (_selectedConsultant == null || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona consultor y calificación')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Has calificado a $_selectedConsultant con $_rating estrellas.\nComentario: ${_commentController.text.trim()}'),
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
          icon: Icon(filled ? Icons.star : Icons.star_border,
              color: filled ? Colors.amber : Colors.grey),
          onPressed: () => setState(() => _rating = i + 1),
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
              value: _selectedConsultant,
              hint: const Text('Selecciona consultor'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Consultor',
              ),
              items: _consultants
                  .map((c) =>
                  DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedConsultant = value),
            ),
            const SizedBox(height: 24),
            const Text('Calificación', style: TextStyle(fontSize: 16)),
            _buildStars(),
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
                label: const Text('Enviar Calificación'),
                onPressed: _submitRating,
              ),
            )
          ],
        ),
      ),
    );
  }
}