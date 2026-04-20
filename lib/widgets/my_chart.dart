import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  final List<FlSpot> spotsPatron;
  final List<FlSpot> spotsEquipo;

  const MyChart({
    super.key,
    required this.spotsPatron,
    required this.spotsEquipo,
  });

  @override
  Widget build(BuildContext context) {
    if (spotsPatron.isEmpty || spotsEquipo.isEmpty) return const SizedBox();

    double minX = [...spotsPatron, ...spotsEquipo].map((s) => s.x).reduce(min);
    double maxX = [...spotsPatron, ...spotsEquipo].map((s) => s.x).reduce(max);
    double minY = [...spotsPatron, ...spotsEquipo].map((s) => s.y).reduce(min);
    double maxY = [...spotsPatron, ...spotsEquipo].map((s) => s.y).reduce(max);

    double marginX = (maxX - minX) * 0.15;
    double marginY = (maxY - minY) * 0.15;

    if (marginX == 0) marginX = 1.0;
    if (marginY == 0) marginY = 1.0;

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          minX: minX - marginX,
          maxX: maxX + marginX,
          minY: minY - marginY,
          maxY: maxY + marginY,
          lineTouchData: const LineTouchData(enabled: true),
          lineBarsData: [
            // LÍNEA PATRÓN (AZUL) - Discontinua (Dashed)
            LineChartBarData(
              spots: spotsPatron,
              isCurved: false,
              barWidth: 2,
              color: Colors.blue,
              dashArray: [5, 5], // Esto crea los guiones
              dotData: const FlDotData(show: false),
            ),
            // LÍNEA EQUIPO (ROJA) - Continua
            LineChartBarData(
              spots: spotsEquipo,
              isCurved: false,
              barWidth: 3,
              color: Colors.red.withOpacity(
                0.8,
              ), // Un poco de transparencia ayuda
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: Colors.red,
                      strokeWidth: 1,
                      strokeColor: Colors.white,
                    ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.grey[300], strokeWidth: 1),
            getDrawingVerticalLine: (value) =>
                FlLine(color: Colors.grey[300], strokeWidth: 1),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey[400]!),
          ),
        ),
      ),
    );
  }
}
