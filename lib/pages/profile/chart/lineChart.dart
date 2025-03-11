import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksReadChart extends StatelessWidget {
  final List<dynamic> data;

  BooksReadChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<dynamic> book_stastic = [];
    int NBdata = 0;
    if (data.isNotEmpty) {
      data[0].forEach((key, value) {
        for (int i = 0; i < value.length; i++) book_stastic.add(value[i]);
      });
    }

    NBdata = mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;
    List<Color> gradientColors = [Colors.yellow, Colors.blue];
    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      final localeProv = Provider.of<LocaleProvider>(context);
      const style = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Color.fromARGB(255, 96, 95, 95));
      Widget text;
      switch (value.toInt()) {
        case 1:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'JAN' : "يناير",
              style: style);
          break;
        case 3:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'MAR' : "مارس",
              style: style);
          break;
        case 5:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'MAY' : "ماي",
              style: style);
          break;
        case 7:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'JULY' : "يوليو",
              style: style);
          break;
           case 9:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'SEP' : "سبتمبر",
              style: style);
          break;
           case 11:
          text = Text(
              localeProv.localelang!.languageCode == "en" ? 'OCT' : "أكتوبر",
              style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Transform(
            alignment: Alignment.center,
            transform: localeProv.localelang!.languageCode == "en"
                ? Matrix4.rotationY(0)
                : Matrix4.rotationY(3.1416),
            child: text),
      );
    }
      Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '5';
        break;
      case 5:
        text = '10';
        break;
      case 10:
        text = '15';
        break;
      default:
        return Container();
    }
final localeProv = Provider.of<LocaleProvider>(context);
    return Transform(
            alignment: Alignment.center,
            transform: localeProv.localelang!.languageCode == "en"
                ? Matrix4.rotationY(0)
                : Matrix4.rotationY(3.1416),child: Text(text, style: style, textAlign: TextAlign.left));
  }

    final localeProv = Provider.of<LocaleProvider>(context);
    return Transform(
      alignment: Alignment.center,
      transform: localeProv.localelang!.languageCode == "en"
          ? Matrix4.rotationY(0)
          : Matrix4.rotationY(3.1416),
      child: LineChart(LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 1,
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
                interval: 5,
                  getTitlesWidget: leftTitleWidgets,
                reservedSize: 25,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.transparent),
          ),
          minX: 0,
          maxX: 12,
          minY: 0,
          maxY: 15,
          lineBarsData: [
            LineChartBarData(
              spots: data.isNotEmpty
                  ? NBdata != 0
                      ? (book_stastic.map((e) {
                          print(((e['timestamp'].toDate()).month).toDouble());
                          return FlSpot(
                            ((e['timestamp'].toDate()).month).toDouble(),
                            e['booksRead'].toDouble(),
                          );
                        }).toList())
                      : List.empty()
                  : List.empty(),
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
          ])),
    );
  }
}
