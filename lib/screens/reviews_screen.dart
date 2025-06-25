import 'package:flutter/material.dart';
import '../data/models/review.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  Widget _buildStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Review> reviews = [
      Review(
        id: '1',
        userId: 'u1',
        rating: 5,
        comment: 'Excelente atención y asesoría.',
        date: '2025-06-01',
      ),
      Review(
        id: '2',
        userId: 'u2',
        rating: 4,
        comment: 'Muy buen servicio, aunque podría mejorar el tiempo de respuesta.',
        date: '2025-06-03',
      ),
      Review(
        id: '3',
        userId: 'u3',
        rating: 3,
        comment: 'Regular, esperaba más opciones personalizadas.',
        date: '2025-06-04',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Reseñas de usuarios')),
      body: reviews.isEmpty
          ? const Center(
          child: Text('No hay reseñas todavía.', style: TextStyle(color: Colors.grey)))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Text(
                  review.rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                review.comment,
                style: const TextStyle(fontSize: 15),
              ),
              subtitle: Text('Fecha: ${review.date}'),
              trailing: _buildStars(review.rating),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}