import 'dart:convert';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/pages/home/collection/collection.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksListScreen extends StatefulWidget {
  @override
  _BooksListScreenState createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  List<Book> books = [];
  int pageNumber = 1;
  bool isLoading = false;
  bool hasMoreBooks = true;
  String key_category = "";
  String DEFAULT_TOKEN =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYW1laWQiOiI5NDllM2VkNy02YjBhLTQ3ZDItODNlOC00ZWU0MjA4OWQ4OGMiLCJlbWFpbCI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYmYiOjE3NDE3NTk1NTEsImV4cCI6MTc0NDM1MTU1MSwiaWF0IjoxNzQxNzU5NTUxfQ.cR0Yb5xYeoVxjRhO4W13MziuzWJ1vlbP6I3hgL5iZeuTiKfV50calIXVjoDQHw1S-5Zr28r5n85pBZtjaidEQQ";

  @override
  void initState() {
    super.initState();
    key_category = Get.arguments[2];
    fetchBooks();

    Future.delayed(Duration.zero, () async {
       final booksApi = Provider.of<BooksApi>(context, listen: false);
    await booksApi.getBooksCount();
    });
  }

  Future<void> fetchBooks() async {
    if (isLoading || !hasMoreBooks) return;

    setState(() {
      isLoading = true;
    });

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };
    int page = 12;
    if (key_category != null && key_category != "") {
      page = 100;
    }

    final Uri url = Uri.parse(
        "https://getejaz.com/api/ejaz/v1/Book/getBooks/?Status=active&PageSize=$page&PageNumber=$pageNumber&OrderBy=title&OrderAs=DESC");

    try {
      final response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        setState(() {
          books.addAll(newBooks);
          pageNumber++;
          isLoading = false;
          if (newBooks.isEmpty) hasMoreBooks = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Failed to load books: ${response.statusCode}");
          final booksApi = Provider.of<BooksApi>(context, listen: false);
        String ErrorValue = "${requestHeaders.toString()},\n${response.body.toString()}";
         await booksApi.handleError(context, ErrorValue,"getBooks");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final themeProv = Provider.of<ThemeProvider>(context);
    final orientation = MediaQuery.of(context).orientation;
    final localeProv = Provider.of<LocaleProvider>(context);
    int getbookCounts =
        Provider.of<BooksApi>(context, listen: false).CountBooks;

    final theme = Theme.of(context);
    List<Book> filteredBooks = books.where((book) {
      return key_category == null ||
          key_category.isEmpty ||
          (book.categories.isNotEmpty &&
              book.categories[0]['ct_Name'] == key_category);
    }).toList();
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        body: LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: fetchBooks, // Calls fetchBooks when scrolled to the end
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Top Title Widget
              Consumer<BooksApi>(
                builder: (context, booksApi, child) {
                  return buildSettingApp(
                    context,
                    title: localeProv.localelang!.languageCode == 'en'
                        ? "Showing ${key_category == "" ? booksApi.CountBooks : filteredBooks.length} books"
                        : "عرض ${key_category == "" ? booksApi.CountBooks : filteredBooks.length} كتب",
                    style:
                        theme.textTheme.headlineLarge!.copyWith(fontSize: 17),
                    trailing: Container(),
                    onTap: () {},
                  );
                },
              ),

              const SizedBox(height: 10),
              Expanded(
                child: filteredBooks.isEmpty && !isLoading
                    ? Center(
                        child: Text(
                         localeProv.localelang!.languageCode == 'en'? "Please Refresh the Page":"من فضلك قم بالتحديث",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Stack(
                        children: [
                          Center(
                            // Ensure GridView is centered
                            child: GridView.builder(
                              shrinkWrap:
                                  true, // Prevent unnecessary scroll issues
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: height * 0.29,
                                crossAxisCount:
                                    (orientation == Orientation.portrait)
                                        ? 3
                                        : 6,
                              ),
                              itemCount: filteredBooks.length,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                var book = filteredBooks[index];
                                return BookCardDetailsCategory(book: book);
                              },
                            ),
                          ),

                          // Show Loading in the Absolute Center
                          if (isLoading)
                            Positioned.fill(
                              child: Container(
                                // Optional: Faded background
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      ),
              )
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor:
                  themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
              pinned: true,
              centerTitle: true,
              automaticallyImplyLeading: true,
            ),
          ];
        },
      ),
    );
  }
}
