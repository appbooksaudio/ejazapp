import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/_Statistic.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/profile/chart/barchart.dart';
import 'package:ejazapp/pages/profile/chart/lineChart.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/placeholders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ejazapp/l10n/app_localizations.dart';

import 'package:shimmer/shimmer.dart';

class Statistic extends StatefulWidget {
  const Statistic({super.key});

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  late Future<List<Map<String, dynamic>>> monthlyData;
  late Future<List<Map<String, dynamic>>> weekdayData;
  int getbookCounts = 500;
  bool loading = false;
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

    monthlyData = getDocumentsByIds();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      GetBookTrack();
    });
    // weekdayData = getBooksReadForLastWeek();
  }

  Future<List<Map<String, dynamic>>> getDocumentsByIds() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      // Reference to your Firestore collection
      CollectionReference books =
          FirebaseFirestore.instance.collection('books_read');

      // Create a list to hold the document data
      List<Map<String, dynamic>> documentsData = [];

      // Loop through each document ID and fetch the document data

      DocumentSnapshot docSnapshot =
          await books.doc(_auth.currentUser!.uid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        documentsData.add(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print('Document with ID ${_auth.currentUser!.uid} does not exist');
      }
      List<Map<String, dynamic>> listdate = [];
      for (int i = 0; i < documentsData.length; i++) {
        listdate.add(Map.from({'listdate': documentsData[i]['listdate']}));
        mybox!.put("BookRead", documentsData[i]['booksRead']);
        setState(() {
          BookRead =
              mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;
        });
      }

      return listdate;
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  GetBookTrack() async {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    await booksApi.getBooksCount();
    getbookCounts = await booksApi.CountBooks;
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    lang = Get.arguments;
    BookRead = mybox!.get("BookRead") != null ? mybox!.get("BookRead") : 0;
    BookReading =
        mybox!.get("BookReading") != null ? mybox!.get("BookReading") : 0;

    stat = [
      UStatistic(lang == "ar" ? "لم يقرأ بعد" : "To Read",
          getbookCounts - BookRead - BookReading),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
          centerTitle: false,
        ),
        //   body: NestedScrollView(
        // physics: NeverScrollableScrollPhysics(),
        body: loading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: Text(
                      AppLocalizations.of(context)!
                          .stastic, // AppLocalizations.of(context)!.change_language,
                      style:
                          theme.textTheme.headlineLarge!.copyWith(fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ), //
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        mainAxisExtent: 200,
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 3 : 6,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height),
                      ),
                      itemCount: 3,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 20),
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
                                    percent: stat[index].number / getbookCounts,
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
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: colors[index]),
                                ),
                                Text(
                                  stat[index].month,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: colors[index]),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 10), // Avoid double padding
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
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
                                      child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                        future: monthlyData,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          }

                                          return BarChartE(localeProv,
                                              data: snapshot.data!.isNotEmpty
                                                  ? snapshot.data!
                                                  : []); //BooksReadChart(data: snapshot.data!);
                                        },
                                      )),
                                  const SizedBox(
                                    height: 37,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 30.0,
                                      right: 30,
                                    ),
                                    child: Text(
                                      localeProv.localelang!.languageCode ==
                                              "ar"
                                          ? 'الكتب المقروءة /اسبوع'
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
                          height: 30,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: 250,
                              color: themeProv.isDarkTheme!
                                  ? Colors.white
                                  : ColorDark.background,
                              child: Stack(children: [
                                FutureBuilder<List<Map<String, dynamic>>>(
                                  future: monthlyData,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }

                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }

                                    return BooksReadChart(
                                        data: snapshot.data!.isNotEmpty
                                            ? snapshot.data!
                                            : []);
                                  },
                                ),
                                const SizedBox(
                                  height: 37,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30,
                                  ),
                                  child: Text(
                                    localeProv.localelang!.languageCode == "ar"
                                        ? 'الكتب المقروءة /شهر'
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
                              ]),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
