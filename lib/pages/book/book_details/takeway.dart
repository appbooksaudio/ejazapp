import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/payment/paymentgateway.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as html_parser;

class takeway extends StatefulWidget {
  const takeway({super.key});

  @override
  State<takeway> createState() => _takewayState();
}

class _takewayState extends State<takeway> {
  Book? book;
  String LanguageStatus = "en";
  @override
  void initState() {
    super.initState();
    book = Get.arguments[0] as Book;
    LanguageStatus = Get.arguments[1] as String;
  }

  @override
  Widget build(BuildContext context) {
    List singletakeway = [];
    List singletakewayAr = [];
    List<Book> listTakeway = [];

    for (var i = 0; i < mockBookList.length; i++) {
      if (mockBookList[i].categories.length > 0) {
        if (mockBookList[i].categories[0]['ct_Name'] != 'Novels' &&
            mockBookList[i].bk_ID == book!.bk_ID) {
          listTakeway.add((mockBookList[i]));

          String htmlContent = mockBookList[i].bk_Characters_Ar!;
          // Convert HTML to plain text
          String plainText = html_parser.parse(htmlContent).body!.text;
          // Split based on double newlines
          List<String> takrabic = plainText.split(RegExp(r'\d+\.\s'));
          for (var i = 0; i < takrabic.length; i++) {
            singletakewayAr.add(takrabic[i]);
          }

          String htmlContentEn = mockBookList[i].bk_Characters!;
          // Convert HTML to plain text
          String plainTextEn = html_parser.parse(htmlContentEn).body!.text;

          List takrenglish = plainTextEn.split(RegExp(r'\d+\.\s'));
          for (var i = 0; i < takrenglish.length; i++) {
            singletakeway.add(takrenglish[i]);
          }
        }
      }
    }

    print('values    ${singletakeway.length}');
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Scaffold(
        backgroundColor:
            themeProv.isDarkTheme! ? ColorDark.background : Color(0xFFdde3f9),
        body: NestedScrollView(
          body: (localprovider.localelang!.languageCode == 'en'
                  ? singletakeway.isNotEmpty
                  : singletakewayAr.isNotEmpty)
              ? (localprovider.localelang!.languageCode == 'en'
                      ? singletakeway[0] != 'N/A'
                      : singletakewayAr[0] != 'N/A')
                  ? Stack(
                      textDirection: LanguageStatus == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 0),
                          child: Text(
                            LanguageStatus == 'en' ? "Takeaway" : "بإيجاز",
                            //AppLocalizations.of(context)!.takeaway,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: themeProv.isDarkTheme!
                                    ? Colors.white
                                    : ColorDark.background),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListView.separated(
                            itemCount: LanguageStatus ==
                                    'ar' //localprovider.localelang!.languageCode
                                ? singletakewayAr.length - 1
                                : singletakeway.length - 1,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  textColor: themeProv.isDarkTheme!
                                      ? Colors.white
                                      : ColorDark.background,
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      textDirection: LanguageStatus == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      children: <Widget>[
                                        // Numbering with bold font
                                        Container(
                                          width: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: themeProv.isDarkTheme!
                                                  ? Colors.white
                                                  : ColorDark.background,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                10), // Add spacing between number and text
                                        Expanded(
                                          child: Html(
                                            data: LanguageStatus == 'ar'
                                                ? singletakewayAr[index + 1]
                                                    .replaceFirst(
                                                        RegExp(r'^\d+\.\s*'),
                                                        '')
                                                : singletakeway[index + 1]
                                                    .replaceFirst(
                                                        RegExp(r'^\d+\.\s*'),
                                                        ''),
                                            style: {
                                              "body": Style(
                                                fontSize: FontSize(18),
                                                lineHeight:
                                                    LineHeight.number(1.2),
                                                textAlign: TextAlign.justify,
                                                direction:
                                                    LanguageStatus == 'ar'
                                                        ? TextDirection.rtl
                                                        : TextDirection.ltr,
                                                color: themeProv.isDarkTheme!
                                                    ? Colors.white70
                                                    : ColorDark.background,
                                              ),
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 2,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: EmptyWidget(
                        image: Const.takeway,
                        title: AppLocalizations.of(context)!.take_title,
                        subtitle: AppLocalizations.of(context)!.take_subtile,
                      ),
                    )
              : Center(
                  child: EmptyWidget(
                    image: Const.takeway,
                    title: AppLocalizations.of(context)!.take_title,
                    subtitle: AppLocalizations.of(context)!.take_subtile,
                  ),
                ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: OutlinedButton.icon(
                          onPressed: () {
                            if (LanguageStatus == 'en') {
                              setState(() {
                                LanguageStatus = 'ar';
                              });
                            } else {
                              setState(() {
                                LanguageStatus = 'en';
                              });
                            }
                            setState(() {});
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              themeProv.isDarkTheme!
                                  ? ColorDark.background
                                  : Colors.transparent,
                            ),
                          ),
                          icon: const Icon(Icons.language, size: 30),
                          label: Text('')
                          // Text(
                          //   LanguageStatus == 'ar' ? "En" : "ع",
                          //   style: LanguageStatus == 'ar'
                          //       ? TextStyle(
                          //           fontSize: 18, fontWeight: FontWeight.bold)
                          //       : TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                          ),
                    ),
                  ],
                  backgroundColor: themeProv.isDarkTheme!
                      ? ColorDark.background
                      : Color(0xFFdde3f9),
                  foregroundColor:
                      themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
                  pinned: true,
                  centerTitle: true,
                  automaticallyImplyLeading: true),
            ];
          },
        ));
  }
}
