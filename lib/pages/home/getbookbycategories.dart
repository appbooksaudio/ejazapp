import 'dart:convert';
import 'package:ejazapp/connectapi/linkapi.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageTabBar extends StatefulWidget {
  const HomePageTabBar({super.key, required this.controller});
  final BooksApi controller;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Category> _categories = [];
  Map<String, List<Book>> _categoryBooks = {}; // Store books per category
  Map<String, bool> _isLoadingBooks = {}; // Track loading state per category
  Map<String, int> _categoryPage = {}; // Track page number per category
  // Create a ScrollController
  Map<String, ScrollController> _scrollControllers =
      {}; // Store scroll controllers per category
  String DEFAULT_TOKEN = AppLink.DEFAULT_TOKEN;

  @override
  void initState() {
    super.initState();
    fetchCategories().then((categories) {
      setState(() {
        _categories = categories;
        _tabController = TabController(length: _categories.length, vsync: this);
        // Listen for tab changes
        _tabController.addListener(() {
          if (_tabController.indexIsChanging) {
            String categoryId = _categories[_tabController.index].ctID;
            fetchBooks(categoryId); // Fetch books on tab switch
          }
        });

        // Initial fetch for first category
        if (_categories.isNotEmpty) {
          fetchBooks(_categories.first.ctID);
        }
      });
    }).catchError((error) {
      print('Error fetching categories: $error');
    });
  }

  @override
  void dispose() {
    _scrollControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(AppLink.getCategories));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchBooks(String categoryID, {bool isLoadMore = false}) async {
    if (_isLoadingBooks[categoryID] == true || _categoryPage[categoryID] == -1)
      return; // Prevent multiple fetches or infinite loop
    if (!mounted) return;
    setState(() {
      // Show loading indicator only if it's not a load more action
      if (!isLoadMore) {
        _isLoadingBooks[categoryID] = true;
      }
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'Expires': '0',
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    // Get current page from _categoryPage or default to 1
    final currentPage = _categoryPage[categoryID] ?? 1;

    // Increment the page number for the next fetch
    _categoryPage[categoryID] = currentPage + 1;

    final url = Uri.parse(
      '${AppLink.server}/Book/getBookByCategory/$categoryID/?Status=active&PageSize=10&PageNumber=$currentPage&OrderBy=Title&OrderAs=DESC',
    );

    try {
      final response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: 60));
      if (!mounted) return; // ✅ Safe check again before any state update
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (!mounted) return; // ✅ Check again before setState
        setState(() {
          if (data.isNotEmpty) {
            if (_categoryBooks[categoryID] == null) {
              _categoryBooks[categoryID] = [];
            }

            // Map the new books fetched from API
            final newBooks = data.map((json) => Book.fromJson(json)).toList();

            // Add only non-duplicate books by comparing IDs
            final existingBooks = _categoryBooks[categoryID]!;
            final filteredBooks = newBooks
                .where((book) => !existingBooks
                    .any((existingBook) => existingBook.bk_ID == book.bk_ID))
                .toList();

            // Add the filtered books to the category list
            _categoryBooks[categoryID]!.addAll(filteredBooks);
            // If no new books are added, stop fetching
            // If the number of books fetched is less than the page size, stop fetching more
            if (filteredBooks.length < 10) {
              _categoryPage[categoryID] =
                  -1; // Set to -1 to indicate no more pages
            }
          }
          _isLoadingBooks[categoryID] = false;
        });
      } else {
        print("Failed to load books: ${response.statusCode}");
        if (mounted) {
          setState(() {
            _isLoadingBooks[categoryID] = false;
          });
        }

        final displayName = mybox!.get('name');

        final booksApi = Provider.of<BooksApi>(context, listen: false);
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        await booksApi.handleError(context, errorValue, "getBookByCategory");
      }
    } catch (error) {
      print("Error fetching books: $error");
      if (mounted) {
        setState(() {
          _isLoadingBooks[categoryID] = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localprovider = Provider.of<LocaleProvider>(context);
    return Container(
      height: 350,
      child: _categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 10),
                // TabBar inside the body
                PreferredSize(
                  preferredSize: Size.fromHeight(50.0), // TabBar height
                  child: Container(
                    // color: theme.primaryColor,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: theme.primaryColor,
                      labelColor: theme.primaryColor,
                      unselectedLabelColor: theme.disabledColor,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      tabs: _categories
                          .map((category) => Tab(
                              text:
                                  localprovider.localelang!.languageCode == "en"
                                      ? category.ctTitle
                                      : category.ctTitle_Ar))
                          .toList(),
                    ),
                  ),
                ),
                // TabBarView inside the body
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _categories.map((category) {
                      String categoryID = category.ctID;
                      List<Book>? books = _categoryBooks[categoryID];
                      bool isLoading = _isLoadingBooks[categoryID] ?? false;
// Initialize a new ScrollController if not yet initialized for this category
                      if (!_scrollControllers.containsKey(categoryID)) {
                        _scrollControllers[categoryID] = ScrollController();
                      }
                      return Builder(
                        builder: (context) {
                          if (isLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (books == null || books.isEmpty) {
                            fetchBooks(
                              categoryID,
                            );
                            // Show a loading indicator while fetching books
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (scrollNotification
                                          is ScrollEndNotification &&
                                      scrollNotification.metrics.extentAfter ==
                                          0) {
                                    // Check if there are more pages to load
                                    if (_categoryPage[categoryID] == -1) {
                                      print("No more books to fetch.");
                                      return true; // Stop further fetching
                                    }
                                    // Reached the bottom of the list, fetch more books
                                    fetchBooks(categoryID, isLoadMore: true);
                                  }
                                  return false;
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 270,
                                      child: ListView.builder(
                                        controller:
                                            _scrollControllers[categoryID],
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.only(
                                            left: Const.margin),
                                        itemCount: books.length +
                                            (_isLoadingBooks[categoryID] == true
                                                ? 1
                                                : 0),
                                        itemBuilder: (context, index) {
                                          if (index < books.length) {
                                            // 🔹 Show books normally
                                            return BookCard(book: books[index]);
                                          } else {
                                            // 🔹 Show a loading indicator at the end when fetching more books
                                            return Container(
                                              width: 60,
                                              alignment: Alignment.center,
                                              child:
                                                  const CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ));
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}

class Category {
  final String ctID;
  final String ctTitle;
  final String ctTitle_Ar;

  Category(
      {required this.ctID, required this.ctTitle, required this.ctTitle_Ar});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      ctID: json['ct_ID'] ?? '',
      ctTitle: json['ct_Title'] ?? 'No Title',
      ctTitle_Ar: json['ct_Title_Ar'] ?? 'No Title',
    );
  }
}
