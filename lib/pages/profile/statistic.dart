import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/models/_Statistic.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/profile/chart/barchart.dart';
import 'package:ejazapp/pages/profile/chart/lineChart.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Statistic extends StatefulWidget {
  const Statistic({super.key});

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  int BookRead = 0;
  int BookReading = 0;
  String lang = "en";
  List colors = [
    Colors.green,
    Colors.blue,
    const Color.fromARGB(255, 239, 202, 34),
  ];
  List<UStatistic> stat = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetBookTrack();
  }

  GetBookTrack() {
    lang = Get.arguments;
    BookRead = mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;
    BookReading =
        mybox!.get("BookReading") != null ? mybox!.get("BookReading") : 0;

    stat = [
      UStatistic(lang == "ar" ? "لم يقرأ بعد" : "To Read",
          mockBookList.length - BookRead - BookReading),
      UStatistic(lang == "ar" ? "تمت قرائته" : "Read", BookRead),
      UStatistic(lang == "ar" ? "بصدد القراءة" : "Reading", BookReading)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProv = Provider.of<LocaleProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final orientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  mainAxisExtent: height * 0.20,
                  crossAxisCount: (orientation == Orientation.portrait) ? 3 : 6,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                ),
                itemCount: 3,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: Const.margin),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    // elevation: 6.0,
                    color: themeProv.isDarkTheme!
                        ? Colors.white
                        : ColorDark.background,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: themeProv.isDarkTheme!
                              ? Colors.white
                              : ColorDark.background,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            child: new CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 6.0,
                              percent: stat[index].number / mockBookList.length,
                              center: new Icon(
                                Feather.book_open,
                                size: 20.0,
                                color: colors[index],
                              ),
                              progressColor: colors[index],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${stat[index].number}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: colors[index]),
                          ),
                          Text(
                            stat[index].month,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: colors[index]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Flexible(
            child: ListView(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 250,
                      color: themeProv.isDarkTheme!
                          ? Colors.white
                          : ColorDark.background,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                right: 0,
                                left: 0,
                                top: 30,
                                bottom: 5,
                              ),
                              child: BarChartE(localeProv)),
                          const SizedBox(
                            height: 37,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                            ),
                            child: Text(
                              localeProv.localelang!.languageCode == "ar"
                                  ? 'الكتب المقروئة /اسبوع'
                                  : "Books read/week",
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
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 250,
                      color: themeProv.isDarkTheme!
                          ? Colors.white
                          : ColorDark.background,
                      child: LineChartSample2(),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor:
                  themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
              title: Text(AppLocalizations.of(context)!.stastic),
              titleTextStyle:
                  theme.textTheme.titleLarge!.copyWith(fontSize: 20),
              pinned: true,
              centerTitle: false,
              automaticallyImplyLeading: true),
        ];
      },
    ));
  }
}
