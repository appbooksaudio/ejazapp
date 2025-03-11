import 'dart:async';

import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/data/models/category.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/pages/for_you/recommended.dart';
import 'package:ejazapp/pages/home/groupes/my_groupes.dart';
import 'package:ejazapp/pages/home/self_developement/self_developement.dart';
import 'package:ejazapp/pages/view_all/all_item.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/LoadingListPage.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:ejazapp/widgets/popup_preference.dart';
import 'package:ejazapp/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ejazapp/pages/payment/slectplan.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});
  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  late List<Book> books;
  String query = '';
  ScrollController? _scrollViewController;
  TabController? _tabController;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  String? _icon;
  Timer? _popupTimer;
  Future<dynamic> getIcon() async {
    final prefs = await SharedPreferences.getInstance();
    String? icon =
        prefs.getString('lang') == null ? 'en' : prefs.getString('lang')!;
    setState(() {
      _icon = icon;
    });
  }

  @override
  void initState() {
    super.initState();
    getIcon();
    _scrollViewController = ScrollController();
    _scrollViewController!.addListener(() {
      if (_scrollViewController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });

    //books = mockBookList;
    // Future.delayed(Duration.zero, () async {
    //   Provider.of<BooksApi>(context, listen: false).getBooks();
    //   Provider.of<BooksApi>(context, listen: false).getCategory();
    //   Provider.of<BooksApi>(context, listen: false).getAuthors();
    // });
    init();
    // Show the popup after 5 seconds
    _popupTimer = Timer(Duration(seconds: 5), () {
      var data = mybox!.get('category');
      if( data ==null || data.length==0 ){ 
        showPreferencePopup(context);
        }
     
    });
    // context.read<LocaleProvider>().initState();
  }

  Future init() async {
    setState(() {
      books = mockBookList;
    });
  }

  void searchBook(String query) {
    final localprovider = Provider.of<LocaleProvider>(context, listen: false);
    final books = mockBookList.where((book) {
      final titleLower = localprovider.localelang!.languageCode == 'en'
          ? book.bk_Name!.toLowerCase()
          : book.bk_Name_Ar!.toLowerCase();
      // Extract author names based on language and convert to lowercase
      final authorLower = book.authors.map((author) {
        // Safely extract author name based on the language
        final name = localprovider.localelang!.languageCode == 'en'
            ? (author['at_Name'] ?? '').toString()
            : (author['at_Name_Ar'] ?? '').toString();
        return name.toLowerCase();
      }).join(' '); // Combine all author names
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.books = books;
    });

 
  }
 

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: AppLocalizations.of(context)!.search_your_favorite_book,
        onChanged: searchBook,
      );
  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollViewController!.dispose();
    // _tabController!.dispose();
    _popupTimer?.cancel(); // Cancel the timer when the widget is disposed

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        buildMainContent(context),
        // if (_showAppbar) buildCollapseAppBar(theme) else const SizedBox(),
        buildCollapseAppBar(theme),
      ],
    );
  }

  Positioned buildCollapseAppBar(ThemeData theme) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      // child: AnimatedContainer(
      //   height: _showAppbar ? 85.0 : 0.0,
      //   duration: const Duration(milliseconds: 1000),
      child: AppBar(
        backgroundColor: theme.colorScheme.surface,
        actions: [
          Padding(
            padding: const EdgeInsets.only(),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.notification),
              child: Icon(
                Feather.mail,
                color: themeProv.isDarkTheme! ? Colors.grey : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: Const.margin),
        ],
      ),
    );
    // );
  }

  List<Book> getLastNBooksAdded(List<Book> books, int n) {
    // Sort the list by addedAt in descending order (most recent first)
    books.sort((a, b) => DateTime.parse(b.bk_CreatedOn!)
        .compareTo(DateTime.parse(a.bk_CreatedOn!)));

    // Return the first N books, or the whole list if N is larger than the list length
    return books.take(n).toList();
  }

  Positioned buildMainContent(BuildContext context) {
//************************ Filter User Choose ****************************//
    final data = mybox!.get('category');
    List<Map<String, String>> getSelect = [];

    if (data != null) {
      // Safely cast each element to Map<String, String>
      getSelect = List<Map<String, String>>.from(data.map((item) =>
              Map<String, String>.from(
                  item as Map)) // Assuming each item is a Map
          );
    }
    List<Book> RecentlyAdded = getLastNBooksAdded(mockBookList, 10);

// Get unique value between RecentlyAdded and getSelect
    List<Map<String, dynamic>> filteredRecentlyAdded =
        RecentlyAdded.map((book) {
      Map<String, dynamic> bookMap = {};
      for (var category in book.categories) {
        // if (category is Map<String, String>) {
        bookMap.addAll(category);
        //  }
      }
      return bookMap;
    }).where((bookMap) {
      return getSelect.any((selected) {
        return selected['ct_Title'] == bookMap['ct_Title'] ||
            selected['ct_Title_Ar'] == bookMap['ct_Title_Ar'];
      });
    }).toList();

    print(filteredRecentlyAdded);

    print('list user select $getSelect');

    final theme = Theme.of(context);

    final isLoading = Provider.of<BooksApi>(context).isLooding;

    return Positioned.fill(
      child: NestedScrollView(
        body: SingleChildScrollView(
          controller: _scrollViewController,
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const SizedBox(height: 85),
              Padding(
                padding: const EdgeInsets.only(
                  left: Const.margin,
                  right: Const.margin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.explore,
                      style: theme.textTheme.headlineLarge!
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: Const.margin),
                padding: const EdgeInsets.symmetric(horizontal: Const.margin),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(child: buildSearch()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (query.isEmpty)
                isLoading
                    ? const LoadingListPage()
                    : Column(
                        children: [
                          buildSettingApp(
                            context,
                            title: AppLocalizations.of(context)!.recommended,
                            style: theme.textTheme.headlineLarge,
                            trailing: _icon == 'en'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "View All",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  )
                                // const Icon(
                                //     Feather.chevrons_right,
                                //     color: ColorLight.primary,
                                //   )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "عرض الكل",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              Get.toNamed<dynamic>(
                                Routes.allitem,
                                arguments: ['', 'lastbook', ''],
                              );
                            },
                          ),
                          const RecommendedExplore(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildSettingApp(
                            context,
                            title: AppLocalizations.of(context)!.recently_added,
                            style: theme.textTheme.headlineLarge,
                            trailing: _icon == 'en'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "View All",
                                      style:
                                          TextStyle(color: ColorLight.primary),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "عرض الكل",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              Get.toNamed<dynamic>(
                                Routes.allitem,
                                arguments: [RecentlyAdded, 'explore', ''],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 270,
                            child: ListView.builder(
                              itemCount: RecentlyAdded.isEmpty
                                  ? mockBookList.length
                                  : RecentlyAdded.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(left: Const.margin),
                              itemBuilder: (context, index) {
                                final book = RecentlyAdded.isEmpty
                                    ? mockBookList[index]
                                    : RecentlyAdded[index];
                                return BookCard(book: book);
                              },
                            ),
                          ),
                          //const SizedBox(height: 20),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //     left: Const.margin,
                          //     right: Const.margin,
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(10)),
                          //           image: DecorationImage(
                          //             image: CachedNetworkImageProvider(
                          //                 'https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/1500-1000.png?alt=media&token=e5488ba0-a4d3-4bec-92a8-d4d8f9da5832'), //AssetImage(Const.cardexplore),//https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/2148320483.jpg?alt=media&token=dd72c589-e224-4c07-a714-9749ed66736b
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         height: height * 0.3,
                          //         width: double.infinity,
                          //         child: Card(
                          //           elevation: 0,
                          //           shape: const RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(10)),
                          //           ),
                          //           color: Colors.transparent,
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: <Widget>[
                          //               SizedBox(
                          //                   child: Column(
                          //                 children: [
                          //                   Padding(
                          //                     padding: EdgeInsets.only(
                          //                         top: 40.0,
                          //                         left: width * 0.2,
                          //                         right: width * 0.1),
                          //                     child: Center(
                          //                       child: Text(
                          //                         AppLocalizations.of(context)!
                          //                             .gift_ejaz_for,
                          //                         maxLines: 2,
                          //                         style: const TextStyle(
                          //                           fontStyle: FontStyle.normal,
                          //                           fontSize: 14,
                          //                           height: 1.2,
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.w300,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: EdgeInsets.only(
                          //                         top: 40.0,
                          //                         left: width * 0.2,
                          //                         right: width * 0.1),
                          //                     child: Center(
                          //                       child: Text(
                          //                         AppLocalizations.of(context)!
                          //                             .you_can_gift_ejaz,
                          //                         maxLines: 2,
                          //                         style: const TextStyle(
                          //                           fontStyle: FontStyle.normal,
                          //                           letterSpacing: 0,
                          //                           wordSpacing: 1,
                          //                           height: 1.2,
                          //                           fontSize: 18,
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.w500,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               )),
                          //               SizedBox(
                          //                 height: 50,
                          //               ),
                          //               Column(
                          //                 children: [
                          //                   Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     children: [
                          //                       const Text(''),
                          //                       if (localeProv.localelang!
                          //                               .languageCode ==
                          //                           'ar')
                          //                         const Text(''),
                          //                       MyRaisedButton(
                          //                         color: Colors.white,
                          //                         width: width * 0.35,
                          //                         onTap: OpenApp,
                          //                         label: AppLocalizations.of(
                          //                           context,
                          //                         )!
                          //                             .gift_ejaz,
                          //                         labelColor:
                          //                             const Color(0xFF11034C),
                          //                       ),
                          //                       const Text(''),
                          //                       const Text(''),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               const SizedBox(
                          //                 height: 10,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          buildSettingApp(
                            context,
                            title: AppLocalizations.of(context)!.trending,
                            style: theme.textTheme.headlineLarge,
                            trailing: _icon == 'en'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "View All",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  )
                                // const Icon(
                                //     Feather.chevrons_right,
                                //     color: ColorLight.primary,
                                //   )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "عرض الكل",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              Get.toNamed<dynamic>(
                                Routes.allitem,
                                arguments: ['', 'lastbook', ''],
                              );
                            },
                          ),
                          const SelfDevelopent(
                            category: '',
                          ),
                          // const SizedBox(height: 20),
                          // const BecomeMenber(),
                          const SizedBox(height: 20),
                          buildSettingApp(
                            context,
                            title: AppLocalizations.of(context)!.mygroupes,
                            style: theme.textTheme.headlineLarge,
                            trailing: Container(),
                          ),
                          const SizedBox(height: 0),
                          const MyGroupes(),
                          if (getSelect.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: getSelect.length,
                              itemBuilder: (context, index) {
                                final localeProv =
                                    Provider.of<LocaleProvider>(context);

                                final category = localeProv
                                            .localelang!.languageCode ==
                                        'en'
                                    ? getSelect.isNotEmpty
                                        ? getSelect[index]['ct_Title'] as String
                                        : ''
                                    : getSelect.isNotEmpty
                                        ? getSelect[index]['ct_Title_Ar']
                                            as String
                                        : '';
                                return Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    buildSettingApp(
                                      context,
                                      title: category,
                                      style: theme.textTheme.headlineLarge,
                                      trailing: _icon == 'en'
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "View All",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: const Text(
                                      "عرض الكل",
                                      style: TextStyle(
                                        color: ColorLight.primary,
                                      ),
                                    ),
                                  ),
                                      onTap: () {
                                        CategoryL? catSelect;
                                        for (var i = 0;
                                            i < CategoryList.length;
                                            i++) {
                                          if ((CategoryList[i].ct_Name ==
                                                  category) ||
                                              (CategoryList[i].ct_Name_Ar ==
                                                  category)) {
                                            catSelect = CategoryList[i];
                                          }
                                        }
                                        Get.toNamed<dynamic>(
                                          Routes.category,
                                          arguments: catSelect,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    ListFilterCategory(category: category),
                                  ],
                                );
                              },
                            )
                          else
                            const Text(''),
                          const SizedBox(height: 20),
                        ],
                      )
              else
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];

                      return buildBook(book);
                    },
                  ),
                ),
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: theme.colorScheme.surface,
              pinned: true,
              centerTitle: true,
            ),
          ];
        },
      ),
    );
  }

  Widget buildBook(Book book) {
    final localprovider = Provider.of<LocaleProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        if (book.bk_trial! != true) {
          PaymentDo(context);
          return;
        }
        Get.toNamed<dynamic>(
          Routes.bookdetail,
          arguments: [book, '', localprovider.localelang!.languageCode],
        );
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              book.imagePath,
              fit: BoxFit.contain,
              width: 70,
              height: 70,
            ),
          ),
        ),
        title: Text(
          localprovider.localelang!.languageCode == 'en'
              ? book.bk_Name!
              : book.bk_Name_Ar!,
          style: TextStyle(
            height: 1.3,
            color: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
          ),
        ),
        // subtitle: Text(book.authors!),
      ),
    );
  }

  void slidersOnTap() {}
}

OpenApp() {
  final name = mybox!.get('name');
  if (name == 'Guest') {
    Get.showSnackbar(GetSnackBar(
      title: 'Ejaz',
      message:
          AppLocalizations.of(Get.context as BuildContext)!.messagetoguestuser,
      duration: const Duration(seconds: 5),
      titleText: Column(
        children: [],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      icon: const Icon(Icons.mood_bad),
    ));
    return;
  }
  Get.toNamed<dynamic>(Routes.giftejaz);
  // Get.snackbar(
  //   'Alert',
  //   'Comming Soon',
  //   colorText: Colors.white,
  //   backgroundColor: Colors.redAccent,
  //   icon: const Icon(Icons.hourglass_disabled),
  // );
}

InkWell buildSettingApp(
  BuildContext context, {
  required String title,
  TextStyle? style,
  IconData? icon,
  Widget? trailing,
  void Function()? onTap,
}) {
  final themeProv = Provider.of<ThemeProvider>(context);
  return InkWell(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: themeProv.isDarkTheme! ? Colors.white : Colors.black,
        ),
        // const SizedBox(width: 15),
        Expanded(child: Text(title, style: style)),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 6, right: 6),
          child: trailing!,
        )
      ],
    ),
  );
}
