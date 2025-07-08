import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/review.dart';
import '../services/language_service.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late List<Review> reviews;

  final Map<String, String> clientMap = {
    'u4': 'Jorge Mendoza',
    'u5': 'Andrea Salas',
    'u6': 'Luis Carranza',
    'u7': 'Carla Ríos',
  };

  List<String> requestedUserIds = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lang = Provider.of<LanguageService>(context, listen: false).language;

      setState(() {
        reviews = lang == 'es'
            ? [
          Review(id: '1', userId: 'u1', rating: 5, comment: 'Excelente atención y asesoría.', date: '2025-06-01'),
          Review(id: '2', userId: 'u2', rating: 4, comment: 'Muy buen servicio.', date: '2025-06-03'),
          Review(id: '3', userId: 'u3', rating: 3, comment: 'Regular, esperaba más opciones personalizadas.', date: '2025-06-04'),
        ]
            : [
          Review(id: '1', userId: 'u1', rating: 5, comment: 'Excellent attention and advice.', date: '2025-06-01'),
          Review(id: '2', userId: 'u2', rating: 4, comment: 'Very good service.', date: '2025-06-03'),
          Review(id: '3', userId: 'u3', rating: 3, comment: 'Average, expected more personalized options.', date: '2025-06-04'),
        ];
      });
    });
  }

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

  void _requestReview(String userId) {
    setState(() {
      requestedUserIds.add(userId);
    });
  }

  void _simulateReview(String userId) {
    final lang = Provider.of<LanguageService>(context, listen: false).language;

    final sampleComments = lang == 'es'
        ? [
      'Excelente servicio, muy satisfecho.',
      'Gracias por el apoyo, todo fue claro.',
      'Buen trato y asesoría precisa.',
      'Muy amable y resolvió mis dudas.',
      'Me gustó el seguimiento ofrecido.',
    ]
        : [
      'Excellent service, very satisfied.',
      'Thanks for the support, everything was clear.',
      'Good treatment and precise advice.',
      'Very kind and answered my questions.',
      'I appreciated the follow-up provided.',
    ];

    final now = DateTime.now();
    final random = DateTime.now().millisecondsSinceEpoch % sampleComments.length;
    final date = now.subtract(Duration(days: random));

    final newReview = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      rating: 4,
      comment: sampleComments[random],
      date: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
    );

    setState(() {
      reviews.add(newReview);
    });
  }

  void _showRequestDialog(BuildContext context) {
    final lang = Provider.of<LanguageService>(context, listen: false).language;
    final reviewedIds = reviews.map((r) => r.userId).toSet();
    final available = clientMap.keys
        .where((id) => !reviewedIds.contains(id) && !requestedUserIds.contains(id))
        .toList();

    String? selectedClientId;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(lang == 'es' ? 'Solicitar reseña' : 'Request Review'),
          content: DropdownButtonFormField<String>(
            items: available
                .map((id) => DropdownMenuItem(
              value: id,
              child: Text(clientMap[id]!),
            ))
                .toList(),
            onChanged: (value) => selectedClientId = value,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(lang == 'es' ? 'Cancelar' : 'Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (selectedClientId != null) {
                  _requestReview(selectedClientId!);
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        lang == 'es'
                            ? 'Se solicitó reseña a ${clientMap[selectedClientId!]}'
                            : 'Review request sent to ${clientMap[selectedClientId!]}',
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.send),
              label: Text(lang == 'es' ? 'Solicitar' : 'Request'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;
    final reviewedIds = reviews.map((r) => r.userId).toSet();

    final int pending = clientMap.entries.where((entry) {
      final userId = entry.key;
      return !reviews.any((r) => r.userId == userId) &&
          requestedUserIds.contains(userId);
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Reseñas recibidas' : 'Received Reviews'),
      ),
      body: reviews == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...reviews.map((review) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo.shade100,
                    child: Text(review.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  title: Text(review.comment, style: const TextStyle(fontSize: 15)),
                  subtitle: Text(
                      '${lang == 'es' ? 'Fecha' : 'Date'}: ${review.date}'),
                  trailing: _buildStars(review.rating),
                  isThreeLine: true,
                ),
              ),
            )),
            const Divider(),
            if (pending > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  lang == 'es'
                      ? 'Reseñas pendientes: $pending'
                      : 'Pending reviews: $pending',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ...clientMap.entries.map((entry) {
              final userId = entry.key;
              final name = entry.value;

              Icon icon;
              String status;

              final hasResponded = reviews.any((r) => r.userId == userId);
              final hasRequested = requestedUserIds.contains(userId);

              if (hasResponded) {
                icon = const Icon(Icons.check_circle, color: Colors.green);
                status = lang == 'es' ? 'Respondido' : 'Responded';
              } else if (hasRequested) {
                icon = const Icon(Icons.hourglass_top, color: Colors.orange);
                status = lang == 'es' ? 'Pendiente' : 'Pending';
              } else {
                icon = const Icon(Icons.help_outline, color: Colors.grey);
                status = lang == 'es' ? 'No solicitado' : 'Not requested';
              }

              return ListTile(
                title: Text(name),
                subtitle: Text('${lang == 'es' ? 'Estado' : 'Status'}: $status'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(width: 8),
                    if (status == (lang == 'es' ? 'Pendiente' : 'Pending'))
                      IconButton(
                        icon: const Icon(Icons.mark_email_read, color: Colors.blue),
                        onPressed: () => _simulateReview(userId),
                        tooltip: lang == 'es' ? 'Simular reseña' : 'Simulate review',
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRequestDialog(context),
        icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
        label: Text(
          lang == 'es' ? 'Solicitar Reseña' : 'Request Review',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.indigo.shade700,
      ),
    );
  }
}