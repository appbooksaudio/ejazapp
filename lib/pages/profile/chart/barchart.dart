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
    for (int i = 1; i < data.length; i++) {
      // print("weekday ${data[i]['timestamp'].weekday}");
    }
    NBdata = mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;
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
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
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

  Widget getTitles(
    double value,
    TitleMeta meta,
  ) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    String text;
    switch (value.toInt()) {
     
      case 1:
        text =
            this.localeProv.localelang!.languageCode == "en" ? 'Mn' : "الاثنين";

        break;
      case 2:
        text = this.localeProv.localelang!.languageCode == "en"
            ? 'Te'
            : "الثلاثاء";

        break;
      case 3:
        text = this.localeProv.localelang!.languageCode == "en"
            ? 'Wd'
            : "الاربعاء";

        break;
      case 4:
        text =
            this.localeProv.localelang!.languageCode == "en" ? 'Tu' : "الخميس";

        break;
      case 5:
        text =
            this.localeProv.localelang!.languageCode == "en" ? 'Fr' : "الجمعة";

        break;
      case 6:
        text =
            this.localeProv.localelang!.languageCode == "en" ? 'St' : "السبت";

        break;
         case 7:
        text =
            this.localeProv.localelang!.languageCode == "en" ? 'Sn' : "الاحد";
        break;
      
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style,),
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
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            // getTitlesWidget: TopTitles
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData>? get barGroups {
    List<dynamic> uniqueList = [];
    List<int> numbers = [ 1, 2, 3, 4, 5, 6, 7];
    List<dynamic> book_stastic = [];
    if (data.isNotEmpty) {
      data[0].forEach((index, value) {
        for (int i = 0; i < value.length; i++) book_stastic.add(value[i]);
      });
    }

    // Use a map to store only the last occurrence
    Map<dynamic, dynamic> uniqueMap = {
      for (var item in book_stastic) (item["timestamp"]).toDate().weekday: item
    };
    
    
    // Convert back to a list
    uniqueList = uniqueMap.values.toList();
     // Find unique items in numbers that are NOT in uniqueList
   List<int> uniqueItems = numbers.where((item) =>  !uniqueList.any((dynamic element) => (element['timestamp'].toDate().weekday) is int && (element['timestamp'].toDate().weekday) == item)).toList();
   //add unique items to final list uniqueList
    for(int i =0;i<uniqueItems.length;i++){
      uniqueList.add({'booksRead':0,'timestamp':uniqueItems[i]});
    }
   
    print(uniqueList);
    // Use a map to store only the last occurrence

    if (book_stastic.length > 0) {
      return [
        for (int i = 0; i < uniqueList.length; i++)
          BarChartGroupData(
            x:uniqueList[i]['timestamp'] is! int? ((uniqueList[i]['timestamp']).toDate()).weekday:uniqueList[i]['timestamp'],
            barRods: [
              BarChartRodData(
                toY: NBdata != 0
                    ? numbers.contains(uniqueList[i]['timestamp'] is! int? (((uniqueList[i]['timestamp']).toDate()).weekday) :uniqueList[i]['timestamp']) ==
                            true
                        ? uniqueList[i]['booksRead'].toDouble()
                        : 0
                    : 0,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ),
      ];
    } else {
      return [
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
    }
  }
}
