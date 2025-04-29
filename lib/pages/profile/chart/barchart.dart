
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

int NBdata = 0;

class BarChartE extends StatelessWidget {
  final LocaleProvider localeProv;
  final List<dynamic> data;

  const BarChartE(this.localeProv, {required this.data});

  @override
  Widget build(BuildContext context) {
    NBdata = mybox!.get("BookRead") ?? 0;

    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final lang = localeProv.localelang?.languageCode ?? "en";
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );

    String text;
    switch (value.toInt()) {
      case 1:
        text = lang == "en" ? 'Mon' : "الاثنين";
        break;
      case 2:
        text = lang == "en" ? 'Tue' : "الثلاثاء";
        break;
      case 3:
        text = lang == "en" ? 'Wed' : "الاربعاء";
        break;
      case 4:
        text = lang == "en" ? 'Thu' : "الخميس";
        break;
      case 5:
        text = lang == "en" ? 'Fri' : "الجمعة";
        break;
      case 6:
        text = lang == "en" ? 'Sat' : "السبت";
        break;
      case 7:
        text = lang == "en" ? 'Sun' : "الاحد";
        break;
      default:
        text = '';
    }

    return SideTitleWidget(
     // axisSide: meta.axisSide,
      space: 4,
      meta: meta ,
      child: Text(text, style: style),
      
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [Colors.blue, Colors.cyan],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData>? get barGroups {
    List<dynamic> bookStastic = [];
    List<int> allDays = [1, 2, 3, 4, 5, 6, 7];

    // Flatten nested data
    if (data.isNotEmpty) {
      data[0].forEach((index, value) {
        bookStastic.addAll(value);
      });
    }

    // Map weekday => last occurrence
    Map<int, dynamic> uniqueMap = {
      for (var item in bookStastic)
        item["timestamp"].toDate().weekday: item
    };

    // Fill missing days with zero values
    for (int day in allDays) {
      if (!uniqueMap.containsKey(day)) {
        uniqueMap[day] = {
          'booksRead': 0,
          'timestamp': day, // int instead of DateTime
        };
      }
    }

    // Convert map to sorted list by weekday
    List<dynamic> sortedList = uniqueMap.entries
        .map((e) => e.value)
        .toList()
      ..sort((a, b) {
        int dayA = a['timestamp'] is int
            ? a['timestamp']
            : a['timestamp'].toDate().weekday;
        int dayB = b['timestamp'] is int
            ? b['timestamp']
            : b['timestamp'].toDate().weekday;
        return dayA.compareTo(dayB);
      });

    return [
      for (var item in sortedList)
        BarChartGroupData(
          x: item['timestamp'] is int
              ? item['timestamp']
              : item['timestamp'].toDate().weekday,
          barRods: [
            BarChartRodData(
              toY: NBdata != 0 ? item['booksRead'].toDouble() : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
    ];
  }
}

