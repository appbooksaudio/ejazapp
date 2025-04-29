
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksReadChart extends StatelessWidget {
  final List<dynamic> data;

  const BooksReadChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final localeProv = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProv.localelang?.languageCode == "en";
    final transform = Matrix4.rotationY(isEnglish ? 0 : 3.1416);

    final List<dynamic> bookStats = data.isNotEmpty
        ? data[0].values.expand((v) => v as List).toList()
        : [];

    // Group booksRead by month
    Map<int, double> groupedData = {};
    for (var e in bookStats) {
      try {
        final month = e['timestamp'].toDate().month;
        final booksRead = e['booksRead'].toDouble();
        groupedData.update(month, (val) => val + booksRead,
            ifAbsent: () => booksRead);
      } catch (err) {
        print("⚠️ Error parsing data: $err");
      }
    }

    // Convert to FlSpot
    final List<FlSpot> spots = groupedData.entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    print("📊 Grouped FlSpots: $spots");

    // Dynamic max Y for chart
    final double maxY = (spots.isNotEmpty)
        ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 5
        : 20;

    final gradientColors = [Colors.yellow, Colors.blue];

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Color.fromARGB(255, 96, 95, 95),
      );

      final monthNames = {
        1: isEnglish ? 'JAN' : 'يناير',
        3: isEnglish ? 'MAR' : 'مارس',
        5: isEnglish ? 'MAY' : 'مايو',
        7: isEnglish ? 'JULY' : 'يوليو',
        9: isEnglish ? 'SEP' : 'سبتمبر',
        11: isEnglish ? 'OCT' : 'أكتوبر',
      };

      final label = monthNames[value.toInt()] ?? '';
      return SideTitleWidget(
      // axisSide: meta.axisSide,
        meta: meta,
        child: Transform(
          alignment: Alignment.center,
          transform: transform,
          child: Text(label, style: style),
        ),
      );
    }

    Widget leftTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
      final labels = {0: '5', 5: '10', 10: '15'};
      final label = labels[value.toInt()];
      if (label == null) return const SizedBox();

      return Transform(
        alignment: Alignment.center,
        transform: transform,
        child: Text(label, style: style),
      );
    }

    return Transform(
      alignment: Alignment.center,
      transform: transform,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingVerticalLine: (value) => const FlLine(
              color: Colors.transparent,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 5,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.transparent),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(colors: gradientColors),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors
                      .map((c) => const Color.fromARGB(255, 183, 236, 211))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

