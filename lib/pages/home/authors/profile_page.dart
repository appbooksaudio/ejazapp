// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/authors.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/data/models/collections.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:ejazapp/widgets/user/button_widget.dart';
import 'package:ejazapp/widgets/user/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  _AuthorsPageState createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  Authors? authors;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authors = Get.arguments as Authors;
    getAuthorsByCollections(authors!);
  }

  getAuthorsByCollections(Authors authors) async {
    setState(() {
      loading = true;
      print("loading $loading");
    });
    await BooksApi().getAuthorsbyCollections(authors.at_ID);
    setState(() {
      loading = false;
      print("loading $loading");
    });
  }

  @override
  Widget build(BuildContext context) {
    //const authors = Authors;
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: NestedScrollView(
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: authors!.imagePath,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                buildName(authors!),
                //  const SizedBox(height: 24),
                //  Center(child: buildUpgradeButton()),
                const SizedBox(height: 24),
                // NumbersWidget(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: buildBookTab(theme),
                ),
              ],
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    backgroundColor: theme.colorScheme.surface,
                    foregroundColor:
                        themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
                    // backgroundColor: themeProv.isDarkTheme!
                    //     ? ColorDark.background
                    //     : Colors.white,
                    pinned: true,
                    centerTitle: true,
                    automaticallyImplyLeading: true),
              ];
            }));
  }

  Widget buildName(Authors authors) {
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Column(
      children: [
        Text(
          localprovider.localelang!.languageCode == 'ar'
              ? authors.at_Name_Ar
              : authors.at_Name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          '',
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget buildUpgradeButton() => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: 'Follow',
              onClicked: () {},
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              text: 'Message',
              onClicked: () {},
            ),
          ],
        ),
      );

  Widget buildAbout(Authors authors) {
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Text(
            localprovider.localelang!.languageCode == 'ar'
                ? authors.at_Desc_Ar
                : authors.at_Desc,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  SizedBox buildBookTab(ThemeData theme) {
    List<Book> ListBookAut = [];
    for (var i = 0; i < mockBookList.length; i++) {
      if (mockBookList[i].authors.length != 0) {
        if (mockBookList[i].authors[0]['at_ID'] == authors!.at_ID) {
          ListBookAut.add(mockBookList[i]);
        }
      }
    }

    final themeProv = Provider.of<ThemeProvider>(context);
    // const authors = Authors;
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  // indicatorColor: Colors.blue,
                  // dividerColor: Colors.amber,
                  labelColor: Color.fromARGB(255, 55, 149, 226),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                        child: Text(
                      AppLocalizations.of(context)!.about,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: themeProv.isDarkTheme!
                              ? Colors.blue
                              : ColorDark.background),
                    )),
                    Tab(
                      child: Text(
                        AppLocalizations.of(context)!.books,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: themeProv.isDarkTheme!
                                ? Colors.blue
                                : ColorDark.background),
                      ),
                    ),
                    Tab(
                        child: Text(
                      AppLocalizations.of(context)!.collections,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: themeProv.isDarkTheme!
                              ? Colors.blue
                              : ColorDark.background),
                    )),
                  ],
                ),
                Expanded(
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(children: <Widget>[
                        buildAbout(authors!),
                        ListView.builder(
                          itemCount: ListBookAut.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Const.margin,
                            vertical: 15,
                          ),
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final Book book;
                            // ignore: avoid_dynamic_calls, curly_braces_in_flow_control_structures

                            book = ListBookAut[index];
                            return BookVerticalCard(
                              book: book,
                              file: "",
                            );
                          },
                        ),
                        loading == false
                            ? collectionListByauth.isNotEmpty
                                ? ListView.builder(
                                    itemCount: collectionListByauth.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Const.margin,
                                      vertical: 15,
                                    ),
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final Collections collByAu;

                                      collByAu = collectionListByauth[index];

                                      return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: collByAu.bc_Title_Ar != 'N/A'
                                              ? Card(
                                                  elevation: 8.0,
                                                  color: themeProv.isDarkTheme!
                                                      ? ColorDark.background
                                                      : Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Row(
                                                    textDirection: localprovider
                                                                .localelang!
                                                                .languageCode ==
                                                            'ar'
                                                        ? TextDirection.rtl
                                                        : TextDirection.ltr,
                                                    children: [
                                                      Container(
                                                        width: 70,
                                                        height: 70,
                                                        child: Container(
                                                          width: 70.0,
                                                          height: 100.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: CachedNetworkImageProvider(
                                                                  collByAu
                                                                      .imagePath!),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      // const Icon(Feather.book_open),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          localprovider
                                                                      .localelang!
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? collByAu
                                                                  .bc_Title_Ar
                                                              : collByAu
                                                                  .bc_Title,
                                                          textAlign: localprovider
                                                                      .localelang!
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? TextAlign.right
                                                              : TextAlign.left,
                                                          style: theme.textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                  color: themeProv
                                                                          .isDarkTheme!
                                                                      ? Colors
                                                                          .white
                                                                      : ColorDark
                                                                          .background,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container());
                                    },
                                  )
                                : Container(
                                    child: Center(
                                        child: Text(
                                      localprovider.localelang!.languageCode ==
                                              'en'
                                          ? "No Group"
                                          : "لا يوجد مجموعة",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                  )
                            : Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                      ])),
                )
              ])),
    );
  }
}
