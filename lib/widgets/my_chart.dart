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
    return SizedBox(
      height: 300,
      //Lienzo de la grafica
      child: LineChart(
        //configuracion de la grafica(ejes,cuadricula,titulos...)
        LineChartData(
          //lista de lineas
          lineBarsData: [
            //configuracion de lineas(color,grosor,curva)
            LineChartBarData(
              spots:
                  spotsPatron, // puntos que le pasamos desde el viewmodel patron
              isCurved: false, //En principio lo haremos resctas
              barWidth: 3, //Grosor linea
              color: Colors.blue,
            ),
            LineChartBarData(
              spots:
                  spotsEquipo, // puntos que le pasamos desde el viewmodel equipo
              isCurved: false, //En principio lo haremos resctas
              barWidth: 3, //Grosor linea
              color: Colors.red,
            ),
          ],
          //Mostramos titulos, pero no los de arriba y derecha.
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          //Mostrar cuadriculas
          gridData: FlGridData(show: true, drawVerticalLine: true),
        ),
      ),
    );
  }
}
