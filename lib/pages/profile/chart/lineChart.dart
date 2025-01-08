import 'package:ejazapp/providers/locale_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/services.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [Colors.yellow, Colors.blue];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final localeProv = Provider.of<LocaleProvider>(context);
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
            mainData(),
          ),
        ),
        const SizedBox(
          height: 37,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Text(
            localeProv.localelang!.languageCode == "ar"
                ? 'الكتب المقروئة /شهر'
                : "Books read/month",
            style: TextStyle(
              color: Color.fromARGB(255, 95, 94, 94),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final localeProv = Provider.of<LocaleProvider>(context);
    const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Color.fromARGB(255, 96, 95, 95));
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text(
            localeProv.localelang!.languageCode == "en" ? 'MAR' : "مارس",
            style: style);
        break;
      case 5:
        text = Text(
            localeProv.localelang!.languageCode == "en" ? 'JUN' : "جانفي",
            style: style);
        break;
      case 8:
        text = Text(
            localeProv.localelang!.languageCode == "en" ? 'SEP' : "سبتمبر",
            style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Color.fromARGB(255, 96, 95, 95));
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 3:
        text = '30';
        break;
      case 5:
        text = '50';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    int NBdata = mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
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
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.transparent),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: NBdata != 0
              ? const [
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(4.9, 5),
                  FlSpot(6.8, 3.1),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4),
                ]
              : const [
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                  FlSpot(0, 0),
                ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => const Color.fromARGB(255, 183, 236, 211))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
