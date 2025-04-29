// import 'dart:convert';
// import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
// import 'package:ejazapp/data/models/authors.dart';
// import 'package:ejazapp/data/models/book.dart';
// import 'package:ejazapp/pages/home/collection/collection.dart';
// import 'package:ejazapp/providers/locale_provider.dart';
// import 'package:ejazapp/providers/theme_provider.dart';
// import 'package:ejazapp/widgets/book_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../data/models/authors.dart';

// class AuthorsListScreen extends StatefulWidget {
//   @override
//   _BooksListScreenState createState() => _BooksListScreenState();
// }

// class _BooksListScreenState extends State<AuthorsListScreen> {
//   List<Authors> authors = [];
//   List authorsApi =[];
//   int pageNumber = 1;
//   bool isLoading = false;
//   bool hasMoreBooks = true;
//   String key_category = "";
//   String DEFAULT_TOKEN =
//       "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYW1laWQiOiI5NDllM2VkNy02YjBhLTQ3ZDItODNlOC00ZWU0MjA4OWQ4OGMiLCJlbWFpbCI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYmYiOjE3NDE3NTk1NTEsImV4cCI6MTc0NDM1MTU1MSwiaWF0IjoxNzQxNzU5NTUxfQ.cR0Yb5xYeoVxjRhO4W13MziuzWJ1vlbP6I3hgL5iZeuTiKfV50calIXVjoDQHw1S-5Zr28r5n85pBZtjaidEQQ";

//   @override
//   void initState() {
//     super.initState();
//     key_category = Get.arguments[2];
//     fetchAuthors();

   
//   }

//   Future<void> fetchAuthors() async {
//     if (isLoading || !hasMoreBooks) return;

//     setState(() {
//       isLoading = true;
//     });

//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     String? authorized =
//         sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

//     Map<String, String> requestHeaders = {
//       'Content-type': 'application/json',
//       "User-Agent": "Ejaz-App/1.0",
//       "Connection": "keep-alive",
//       'Authorization': 'Bearer $authorized',
//     };
//     int page = 12;
//     if (key_category != null && key_category != "") {
//       page = 100;
//     }

//     final Uri url = Uri.parse(
//         "https://ejaz.applab.qa/api/ejaz/v1/Author/getAuthors/?Status=active&PageSize=$page&PageNumber=$pageNumber&OrderBy=title&OrderAs=DESC");

//     try {
//       final response = await http
//           .get(url, headers: requestHeaders)
//           .timeout(Duration(seconds: 60));

//       if (response.statusCode == 200) {
//        mockAuthors = [];
//         authorsApi = json.decode(response.body) as List;
//         var i = 0;
//         authorsApi.forEach((element) {
//           Map? obj = element as Map;
//           String image = obj['md_ID'] as String;
//           mockAuthors.add(Authors(
//             at_ID: obj['at_ID'] as String,
//             at_Name: obj['at_Name'] as String,
//             at_Name_Ar: obj['at_Name_Ar'] as String,
//             imagePath:
//                 'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
//             at_Active: obj['at_Active'] as bool,
//             at_Desc: obj['at_Desc'] as String,
//             at_Desc_Ar: obj['at_Desc_Ar'] as String,
//             isDarkMode: true,
//           ));
//           i + 1;
//         });

     

//         setState(() {
//           books.addAll(newBooks);
//           pageNumber++;
//           isLoading = false;
//           if (newBooks.isEmpty) hasMoreBooks = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         print("Failed to load books: ${response.statusCode}");
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     final themeProv = Provider.of<ThemeProvider>(context);
//     final orientation = MediaQuery.of(context).orientation;
//     final localeProv = Provider.of<LocaleProvider>(context);

//     final theme = Theme.of(context);
//     List<Book> filteredBooks = books.where((book) {
//       return key_category == null ||
//           key_category.isEmpty ||
//           (book.categories.isNotEmpty &&
//               book.categories[0]['ct_Name'] == key_category);
//     }).toList();
//     return Scaffold(
//       body: NestedScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         body: LazyLoadScrollView(
//           isLoading: isLoading,
//           onEndOfPage: fetchAuthors, // Calls fetchBooks when scrolled to the end
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               Expanded(
//                 child: filteredBooks.isEmpty && !isLoading
//                     ? Center(
//                         child: Text(
//                           "No books available",
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       )
//                     : Stack(
//                         children: [
//                           Center(
//                             // Ensure GridView is centered
//                             child: GridView.builder(
//                               shrinkWrap:
//                                   true, // Prevent unnecessary scroll issues
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 mainAxisSpacing: 10,
//                                 crossAxisSpacing: 10,
//                                 mainAxisExtent: height * 0.29,
//                                 crossAxisCount:
//                                     (orientation == Orientation.portrait)
//                                         ? 3
//                                         : 6,
//                               ),
//                               itemCount: filteredBooks.length,
//                               physics: const BouncingScrollPhysics(),
//                               padding: const EdgeInsets.all(10),
//                               itemBuilder: (context, index) {
//                                 var book = filteredBooks[index];
//                                 return BookCardDetailsCategory(book: book);
//                               },
//                             ),
//                           ),

//                           // Show Loading in the Absolute Center
//                           if (isLoading)
//                             Positioned.fill(
//                               child: Container(
//                                 // Optional: Faded background
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//               )
//             ],
//           ),
//         ),
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               backgroundColor: theme.colorScheme.surface,
//               foregroundColor:
//                   themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
//               pinned: true,
//               centerTitle: true,
//               automaticallyImplyLeading: true,
//             ),
//           ];
//         },
//       ),
//     );
//   }
// }
