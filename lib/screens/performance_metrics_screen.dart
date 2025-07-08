import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class PerformanceMetricsScreen extends StatelessWidget {
  const PerformanceMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Métricas de desempeño' : 'Performance Metrics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              lang == 'es'
                  ? 'Resumen de tu actividad como emprendedor'
                  : 'Summary of your activity as a entrepreneur',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text(lang == 'es' ? 'Asesorías' : 'Advisors');
                            case 1:
                              return Text(lang == 'es' ? 'Reseñas' : 'Reviews');
                            case 2:
                              return Text(lang == 'es' ? 'Finalizados' : 'Completed');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4.6)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}