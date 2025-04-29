// ignore_for_file: strict_raw_type

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ejazapp/connectapi/linkapi.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/firebaseapi/updatetoken.dart';
import 'package:ejazapp/data/models/authors.dart';
import 'package:ejazapp/data/models/banner.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/data/models/category.dart';
import 'package:ejazapp/data/models/collections.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BooksApi extends ChangeNotifier {
  List books = [];
  List collection = [];
  List collectionByAu = [];
  List<Authors> listauthors = [];
  List<Collections> collectionActive = [];
  bool isLooding = false;
  String DEFAULT_TOKEN = AppLink.DEFAULT_TOKEN;
  String Refresh_TOKEN = AppLink.Refresh_TOKEN;
  List<Book> books2 = [];
  int currentPage = 1;
  final int pageSize = 100;
  List<Book> LastDate = [];
  List<Book> booksQuery = [];
  List<Book> BooksByCollection = [];
  List<Book> getbooksbypublishers = [];
  List<Book> getbooksbyauthors = [];
  int CountBooks = 0;
  List<Book> ListBookbyId = [];
  final displayName = mybox!.get('name');


//******************* Function getbooks ******************//
  Future<void> getBooksByCreationDate(
    BuildContext context,
  ) async {
    try {
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
      print("newAccessToken2 $authorized");
      final url = Uri.parse(
          "${AppLink.getbook}PageSize=10&OrderBy=CreatedOn&OrderAs=DESC");

      final response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        LastBooks = [];
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> allBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();
        // Update LastBooks with the last 10 created books
        LastBooks.addAll(allBooks);
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        handleError(context, errorValue, "Getbooks");
      }
    } catch (e) {
      handleError(context, e, "Getbooks");
    } finally {
      notifyListeners();
    }
  }

  //******************** funtion handleError **************/

  handleError(BuildContext context, Object e, String ApisName) async {
    print("Error fetching books: $e");
    //delays between API calls
    // await Future.delayed(Duration(seconds: 3));
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) => ErrorPopup(),
    // );
   // Get.toNamed(Routes.signin);
    sendErrorEmail("$e", ApisName);
  }
  
// Future<void> handleError({
//   required BuildContext context,
//   required Object error,
//   required String apiName,
//   required Future<void> Function() retryFunction,
//   int retryDelaySeconds = 2,
// }) async {
//   print("Error in $apiName: $error");

//   // Only retry for specific errors
//   if (error.toString().contains("401") || error.toString().contains("Unauthorized")) {
//     print("Retrying $apiName after $retryDelaySeconds seconds...");
//     await Future.delayed(Duration(seconds: retryDelaySeconds));

//     try {
//       await retryFunction(); // Try again
//       print("Retry successful for $apiName.");
//       return; // exit if successful
//     } catch (e) {
//       print("Retry failed: $e");
//     }
//   }

//   // Go to sign-in and send error
//   Get.toNamed(Routes.signin);
//   sendErrorEmail("$error", apiName);
// }

  //******************** funtion sortBooksByCreationDate **************/

  List<Book> sortBooksByCreationDate(List<Book> books) {
    books.sort((a, b) {
      DateTime aDate = DateTime.parse(
          a.bk_CreatedOn!); // Assuming 'createdOn' is a DateTime string
      DateTime bDate = DateTime.parse(b.bk_CreatedOn!);
      return bDate.compareTo(aDate); // Sort in descending order
    });
    return books;
  }

  //******************** funtion getBooksCount **************/
  getBooksCount() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl =
        Uri.parse('https://ejaz.applab.qa/api/ejaz/v1/Counts/getBooksCount');

    try {
      final response = await http
          .get(apiUrl, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        CountBooks = json.decode(response.body);
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getBooksCount");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  //******************** funtion PutBooksViews **************/
  PutBooksViews(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl = Uri.parse('${AppLink.server}/Book/bookViews/$id');

    try {
      final response = await http
          .put(apiUrl, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        print('BooksView added');
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "BooksView");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  //******************** funtion GetTrendBooks **************/
  List<Book> trendBook = [];
  GetTrendBooks() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl = Uri.parse('${AppLink.server}/Book/gettrendingbooks');

    try {
      final response = await http
          .get(apiUrl, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        trendBook = [];
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();
        trendBook.addAll(newBooks);
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "GetTrendBooks");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  //********************  Function searchBookQuery **************/
  searchBookQuery(String query) async {
    // Construct API URL to search by title and author
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl = Uri.parse(
        'https://ejaz.applab.qa/api/ejaz/v1/Book/getBookBySearch/0?Search=$query');

    try {
      final response = await http
          .get(apiUrl, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        // Parse the books list from API response
        booksQuery = newBooks.map((book) {
          return Book(
              bk_ID: book.bk_ID,
              bk_Name: book.bk_Name,
              bk_Name_Ar: book.bk_Name_Ar,
              bk_Title: book.bk_Title,
              bk_Title_Ar: book.bk_Title_Ar,
              authors: book.authors,
              categories: book.categories,
              genres: book.genres,
              publishers: book.publishers,
              thematicAreas: book.thematicAreas,
              tags: book.tags,
              imagePath: book.imagePath,
              audioEn: book.audioEn,
              audioAr: book.audioAr,
              bk_trial: book.bk_trial,
              url: book.url // Assuming authors are already a list
              );
        }).toList();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "searchBookQuery");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  //********************  Function searchBookQuery **************/
  searchBookbyId(String id) async {
    ListBookbyId = [];
    // Construct API URL to search by title and author
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl =
        Uri.parse('https://ejaz.applab.qa/api/ejaz/v1/Book/getBook/$id');

    try {
      final response = await http
          .get(apiUrl, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
            json.decode(response.body); // Parse as Map
        Book book = Book.fromJson(jsonResponse); // Convert to Book object
        ListBookbyId.add(book); // Add to the list

        notifyListeners();
        // Parse the books list from API response
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "searchBookbyId");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
  //********************  Function searchBookbyIdList **************/

  Future<Book?> searchBookbyIdList(String id) async {
    // Construct API URL to search by title and author
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    final Uri apiUrl =
        Uri.parse('https://ejaz.applab.qa/api/ejaz/v1/Book/getBook/$id');

    try {
      final response = await http
          .get(apiUrl, headers: requestHeaders)
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Book book = Book.fromJson(jsonResponse);
        return book; // ✅ Return the book directly
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "searchBookbyIdList");
      }
    } catch (e) {
      print('Exception: $e');
    }

    return null; // In case of error
  }

  //******************* Function getbooks ******************//

  getBooks() async {
    print("getBooksgetBooksgetBooksgetBooksgetBooksgetBooks");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };
    final url = Uri.parse(
      AppLink.getbook,
    );
    try {
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        mockBookList = [];
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        mockBookList.addAll(newBooks);
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getBooks");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
  //******************* Function getBooksBypublishers ******************//

  getBooksBypublishers(String id) async {
    getbooksbypublishers = [];
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };
    final url = Uri.parse(
      "${AppLink.getbooksbypublishers}/$id/?Status=active",
    );
    try {
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        getbooksbypublishers.addAll(newBooks);
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getBooksBypublishers");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
  //******************* Function getBooksByAuthors ******************//

  getBooksByAuthors(String id) async {
    getbooksbyauthors = [];
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
        await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };
    final url = Uri.parse(
      "${AppLink.getbooksbyauthors}/$id/?Status=active",
    );
    try {
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        getbooksbyauthors.addAll(newBooks);
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getbooksbyauthors");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

//******************* Function getCategory ******************//

//New APIs selfdevelopement  ////////
  List<Book> selfBook = [];
  Future<void> fetchBooksSelfdevelopement() async {
    final Uri url = Uri.parse(
        "${AppLink.server}/Book/getBookByCategory/ced2cdcf-2af1-466b-5c29-08db6f7c5ea5/?Status=active&PageSize=10&PageNumber=1&OrderBy=Title&OrderAs=DESC");

    try {
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

      final response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();

        selfBook.addAll(newBooks);
        notifyListeners();
        print("Books: $data");
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "Selfdevelopement");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

//******************* Function getCategory ******************//
  getCategory() async {
    try {
      late SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? authorized =
          await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
        // 'Content-Length': '$contentlength',
        //'Host': '0',
        'Authorization': 'Bearer $authorized'
      };
      final url = Uri.parse(
        AppLink.category,
      );
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        CategoryList = [];
        books = json.decode(response.body) as List;
        var i = 0;
        books.forEach((element) {
          Map? obj = element as Map;
          String image = obj['md_ID'] != null ? obj['md_ID'] as String : "";
          CategoryList.add(CategoryL(
              ct_ID: obj['ct_ID'] as String,
              ct_Name: obj['ct_Name'] as String,
              ct_Title: obj['ct_Title'] as String,
              ct_Name_Ar: obj['ct_Name_Ar'] as String,
              ct_Title_Ar: obj['ct_Title_Ar'] as String,
              id: 0,
              imagePath:
                  'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
              md_ID: '',
              title: ''));
          i + 1;
        });
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getCategory");
      }
    } catch (e) {
      print(e);
    }
  }

//************* getAauthors   ************************* */
  Future<void> getAuthors() async {
    try {
      late SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? authorized =
          await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
        // 'Content-Length': '$contentlength',
        //'Host': '0',
        'Authorization': 'Bearer $authorized'
      };
      final url = Uri.parse(
        AppLink.authors,
      );
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        mockAuthors = [];
        books = json.decode(response.body) as List;
        var i = 0;
        books.forEach((element) {
          Map? obj = element as Map;
          String image = obj['md_ID'] as String;
          mockAuthors.add(Authors(
            at_ID: obj['at_ID'] as String,
            at_Name: obj['at_Name'] as String,
            at_Name_Ar: obj['at_Name_Ar'] as String,
            imagePath:
                'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
            at_Active: obj['at_Active'] as bool,
            at_Desc: obj['at_Desc'] as String,
            at_Desc_Ar: obj['at_Desc_Ar'] as String,
            isDarkMode: true,
          ));
          i + 1;
        });

        for (int i = 0; i < mockAuthors.length; i++) {
          if (mockAuthors[i].at_Active == true) {
            listauthors.add(mockAuthors[i]);
          }
        }
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getAuthors");
      }
    } catch (e) {
      print(e);
    }
  }

  //************* getAauthors   ************************* */
  getAuthorsbyCollections(String id) async {
    try {
      late SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? authorized =
          await sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
        // 'Content-Length': '$contentlength',
        //'Host': '0',
        'Authorization': 'Bearer $authorized'
      };
      final url = Uri.parse(
        AppLink.authorsbycollection + "/$id",
      );
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        collectionListByauth = [];
        collectionByAu = json.decode(response.body) as List;
        var i = 0;
        collectionByAu.forEach((element) {
          Map? obj = element as Map;
          String image = obj['md_ID'] as String;
          collectionListByauth.add(Collections(
            bc_ID: obj['bc_ID'] as String,
            bc_Title: obj['bc_Title'] as String,
            bc_Title_Ar: obj['bc_Title_Ar'] as String,
            imagePath:
                'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
            bc_Active: obj['bc_Active'] as bool,
            bc_Desc: obj['bc_Desc'] as String,
            bc_Summaries: obj['bc_Summaries'] as int,
          ));
          i + 1;
        });
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "getAuthorsbyCollections");
      }
    } catch (e) {
      print(e);
    }
  }

  //******************* Function Get Subscription  ******************//

  Future<void> GetSubscription() async {
    try {
      late SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? authorized = sharedPreferences.getString("authorized");
      if (authorized == null || authorized == "") {
        authorized = DEFAULT_TOKEN;
      }

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
        // 'Content-Length': '$contentlength',
        //'Host': '0',
        'Authorization': 'Bearer $authorized'
      };
      final url = Uri.parse(
        AppLink.getsubscritipn,
      );
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        final responsebody = json.decode(response.body) as List<dynamic>;
        await mybox!.put('subscriptionplan', responsebody);
        print("subscription result $responsebody");
      } else {
        // await SendEmailException(response.body, ApiName);
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "GetSubscription");
      }
    } catch (e) {
      print(e);
      sendErrorEmail("$e", "GetSubscription");
    }
  }
  //******************* Function Get EjazCollection  ******************//

  Future<void> GetEjazCollection() async {
    try {
      late SharedPreferences sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? authorized = sharedPreferences.getString("authorized");
      if (authorized == null || authorized == "") {
        authorized = DEFAULT_TOKEN;
      }

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
        // 'Content-Length': '$contentlength',
        //'Host': '0',
        'Authorization': 'Bearer $authorized'
      };
      final url = Uri.parse(
        AppLink.getejazcollection,
      );
      final response = await http.get(
        url,
        headers: requestHeaders,
      ); //,headers: requestHeaders,

      if (response.statusCode == 200) {
        final responsebody = json.decode(response.body) as List<dynamic>;
        await mybox!.put('getejazcollection', responsebody);
        collectionList = [];
        collectionActive = [];
        collection = json.decode(response.body) as List;
        var i = 0;
        collection.forEach((element) {
          Map? obj = element as Map;
          String image = obj['md_ID'] as String;
          collectionList.add(Collections(
            bc_ID: obj['bc_ID'] as String,
            bc_Title: obj['bc_Title'] as String,
            bc_Title_Ar: obj['bc_Title_Ar'] as String,
            imagePath:
                'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
            bc_Active: obj['bc_Active'] as bool,
            bc_Desc: obj['bc_Desc'] as String,
            bc_Summaries: obj['bc_Summaries'] as int,
          ));
          i + 1;
        });
        for (var i = 0; i < collectionList.length; i++) {
          if (collectionList[i].bc_Active != false)
            collectionActive.add(collectionList[i]);
        }
        notifyListeners();
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: requestHeaders,
          uri: url,
          responseBody: response.body,
        );
        sendErrorEmail(errorValue, "GetEjazCollection");
      }
    } catch (e) {
      print(e);
      sendErrorEmail("$e", "GetEjazCollection");
    }
  }

  //******************* Function Get GetBooksByCollection  ******************//
  Future<void> GetBooksByCollectionId(String id) async {
    BooksByCollection = [];
    try {
      // Retrieve authorization token from SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      String authorized =
          sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

      // API request headers
      final Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authorized',
      };

      // Construct API URL
      final Uri url = Uri.parse(
          'https://ejaz.applab.qa/api/ejaz/v1/Book/getBookByCollection/$id/?Status=active');

      // Perform API request after navigation
      final response = await http.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Book> newBooks =
            jsonData.map((data) => Book.fromJson(data)).toList();
        BooksByCollection.addAll(newBooks);
        notifyListeners();
      } else {
        debugPrint("API Error: ${response.statusCode} - ${response.body}");
        throw Exception(
            "Failed to fetch collection. Server returned ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching collection: $e\n$stackTrace");
    }
  }

  //******************* Function Get UpdateProfiles  ******************//
  void UpdateProfiles(fullname, country, gender, bio) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized = DEFAULT_TOKEN;
    }
    if (gender == "null") {
      gender = '';
    }
    Map<String, String> data = {
      "us_Gender": gender != "" ? gender.toString() : "unknow",
      "us_DisplayName": fullname != "" ? fullname.toString() : "unknow",
      "us_Language": "English",
      "us_DOB": "1995-08-13",
      // "Email": "hsinifghwalid@gmail.com",
      // "Username": "walid",
      // "PhoneNumber":"775885",
      //"bio": bio as String,
    };
    int contentlength = utf8.encode(json.encode(data)).length;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.updateprofile,
    );
    final response = await http.put(
      url,
      headers: requestHeaders,
      body: msg,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      print('profiles updated');
      mybox!.put('name', fullname.toString());
    } else {
      //  await SendEmailException(response.body, ApiName);
      print('profiles update error');

      // throw Exception();
    }
  }

  //******************* Function  isUserExist  ******************//
// ignore_for_file: prefer_const_constructors
  isUserExist(BuildContext context, String type, var value, String uid,
      String displayName) async {
    try {
      print("type: $type, value: $value, uid: $uid, displayName: $displayName");

      // Prepare data based on login type
      Map<String, String> data = {
        "email": type == 'google' ? value : "",
        "phoneNumber": type == 'phoneNumber' ? value : "",
        "username": type == 'apple' ? value : "",
      };

      // Calculate the content length
      int contentLength = utf8.encode(json.encode(data)).length;

      // Set up request headers
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Content-Length': '$contentLength',
      };

      // Prepare request body
      final msg = jsonEncode(data);
      final url = Uri.parse(AppLink.checklogin);

      // Send POST request
      final response = await http.post(url, headers: requestHeaders, body: msg);

      if (response.statusCode == 200) {
        print("Checklogin Response: ${response.body}");

        // Handle response logic
        if (response.body != "true") {
          await signupGoogleApple(context, displayName, value, uid, type);
        } else {
          await signGoogleApple(context, value, type);
        }
      } else {
        // Handle if user is null (in case of an error)
        Navigator.pop(context);
        // Show error message if the request fails
        Get.rawSnackbar(
          messageText: Text(
            Get.locale?.languageCode == 'ar'
                ? 'فشل الاتصال. يرجى المحاولة مرة أخرى.'
                : 'Unable to connect. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: ColorLight.primary,
          icon: const Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
        );

// Optionally close the snackbar after a few seconds
        Future.delayed(const Duration(seconds: 3), () {
          Get.closeCurrentSnackbar(); // Close the snackbar after 3 seconds
        });
        sendErrorEmail(response.body.toString(), "isUserExist");
      }
    } catch (e) {
      // Handle if user is null (in case of an error)
      Navigator.pop(context);
      print("Error during CheckLogin: $e");
      sendErrorEmail(e.toString(), "isUserExist");
      // Optional: Handle or log the error properly
    }
  }

//******************* Function signGoogleApple  ******************//

  Future<void> signGoogleApple(
      BuildContext context, String email, String type) async {
    try {
      final data = {
        "Password": 'GoogleApple@12345',
        "Email": email,
      };

      final headers = {
        'Content-Type': 'application/json',
        'Content-Length': utf8.encode(json.encode(data)).length.toString(),
      };

      final response = await http.post(
        Uri.parse(AppLink.login),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint('تسجيل الدخول ناجح / Login successful');
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final isSubscribed = responseBody['isSubscribed'] == true;
        final sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString('name', responseBody['displayName']);
        await sharedPreferences.setString('authorized', responseBody['token']);
        await sharedPreferences.setString(
            'refreshToken', responseBody['refreshToken']);
        await sharedPreferences.setString('image', responseBody['image']);
        await mybox?.put('PaymentStatus', isSubscribed ? 'success' : 'pending');
        tokenExpiryTime = DateTime.now()
            .add(Duration(days: 1)); // Adjust based on API response
        // Fetch Firebase token
        final firebaseToken = await FirebaseMessaging.instance.getToken();
        if (firebaseToken != null) {
          await sharedPreferences.setString('token', firebaseToken);
          UpdateFirebaseToken(firebaseToken);
        }

        Get.offNamed(Routes.home);
      } else {
        _showErrorSnackbar(Get.locale?.languageCode == 'ar'
            ? "فشل تسجيل الدخول ... حاول مرة أخرى"
            : "Login Failed ... try again");
        // Handle if user is null (in case of an error)
        Navigator.pop(context);
        sendErrorEmail(response.body.toString(), "signGoogleApple");
      }
    } catch (e) {
      // Handle if user is null (in case of an error)
      Navigator.pop(context);
      debugPrint("Error: $e");
      _showErrorSnackbar(Get.locale?.languageCode == 'ar'
          ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
          : "An unexpected error occurred. Please try again.");
      sendErrorEmail(e.toString(), "signGoogleApple");
    }
  }
  //******************* Function SignupGoogleApple  ******************//

  Future<void> signupGoogleApple(BuildContext context, String username,
      String email, String firebaseUID, String type) async {
    try {
      final uid = Uuid().v4();
      final displayName = type == 'google' ? username : email;
      final generatedUsername =
          type == 'google' ? "$username@${uid.split('-')[0]}" : email;

      final data = {
        "FirebaseUID": firebaseUID,
        "FirebaseToken": "dfgdfg", // This should be dynamically retrieved
        "DisplayName": displayName,
        "Username": generatedUsername,
        "Password": 'GoogleApple@12345',
        "Email": email,
        "PhoneNumber": firebaseUID,
        "Language": "All",
      };

      final headers = {
        'Content-Type': 'application/json',
        'Content-Length': utf8.encode(json.encode(data)).length.toString(),
      };

      final response = await http.post(Uri.parse(AppLink.signup),
          headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final sharedPreferences = await SharedPreferences.getInstance();
        final isSubscribed = responseBody['isSubscribed'] == true;

        await sharedPreferences.setBool('isLogin', true);
        await sharedPreferences.setString('name', responseBody['displayName']);
        await sharedPreferences.setString('authorized', responseBody['token']);
        await sharedPreferences.setString(
            'refreshToken', responseBody['refreshToken']);
        await sharedPreferences.setString('image', responseBody['image']);
        await mybox?.put('PaymentStatus', isSubscribed ? 'success' : 'pending');
        tokenExpiryTime = DateTime.now()
            .add(Duration(days: 1)); // Adjust based on API response
        // Fetch Firebase token
        final firebaseToken = await FirebaseMessaging.instance.getToken();
        if (firebaseToken != null) {
          await sharedPreferences.setString('token', firebaseToken);
          UpdateFirebaseToken(firebaseToken);
        }

        Get.offAllNamed(Routes.home);
      } else {
        _showErrorSnackbar("User Name or Email Exists!");
        sendErrorEmail(response.body.toString(), "SignupGoogleApple");
        // Handle if user is null (in case of an error)
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error: $e");
      sendErrorEmail(e.toString(), "SignupGoogleApple");
      // Handle if user is null (in case of an error)
      Navigator.pop(context);
    }
  }

  void _showErrorSnackbar(String message) {
    Get.rawSnackbar(
      messageText: Text(
        Get.locale?.languageCode == 'ar'
            ? 'اسم المستخدم أو البريد الإلكتروني موجود!'
            : message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      isDismissible: false,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error, color: Colors.white, size: 35),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
    // Close the snackbar after 3 seconds (adjust time as needed)
    Future.delayed(const Duration(seconds: 3), () {
      Get.closeCurrentSnackbar(); // This will close the snackbar
    });
  }

  //******************* Function SignupGoogleApple  ******************//
  Future<void> signGuest(BuildContext context) async {
    try {
      final data = {
        "Password": 'P@ssw0rd@123',
        "Email": "guestejaz@gmail.com",
      };

      final headers = {
        'Content-Type': 'application/json',
        'Content-Length': utf8.encode(json.encode(data)).length.toString(),
      };

      final response = await http.post(
        Uri.parse(AppLink.login),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint('تسجيل الدخول ناجح / Login successful');
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final isSubscribed = responseBody['isSubscribed'] == true;
        final sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString('name', responseBody['displayName']);
        await sharedPreferences.setString('authorized', responseBody['token']);
        await sharedPreferences.setString(
            'refreshToken', responseBody['refreshToken']);
        await sharedPreferences.setString('image', responseBody['image']);
        await mybox?.put('PaymentStatus', isSubscribed ? 'success' : 'pending');
        tokenExpiryTime = DateTime.now()
            .add(Duration(days: 1)); // Adjust based on API response
        // Fetch Firebase token
        final firebaseToken = await FirebaseMessaging.instance.getToken();
        if (firebaseToken != null) {
          await sharedPreferences.setString('token', firebaseToken);
          await UpdateFirebaseToken(firebaseToken);
        }

        Get.offNamed(Routes.home);
      } else {
        _showErrorSnackbar(Get.locale?.languageCode == 'ar'
            ? "فشل تسجيل الدخول ... حاول مرة أخرى"
            : "Login Failed ... try again");
        // Handle if user is null (in case of an error)
        Navigator.pop(context);
        sendErrorEmail(response.body.toString(), "signGuest");
      }
    } catch (e) {
      // Handle if user is null (in case of an error)
      Navigator.pop(context);
      debugPrint("Error: $e");
      _showErrorSnackbar(Get.locale?.languageCode == 'ar'
          ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
          : "An unexpected error occurred. Please try again.");
      sendErrorEmail(e.toString(), "signGuest");
    }
  }

  //******************* Function Get EjazCollectionById  ******************//
  PaymentPost(
      String pm_RefernceID, int pm_Price, int pm_Days, bool pm_Active) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString('authorized');
    if (authorized == null || authorized == '') {
      authorized = DEFAULT_TOKEN;
    }

    Map<String, dynamic> data = {
      "pm_RefernceID": pm_RefernceID,
      "pm_Price": pm_Price,
      "pm_Days": pm_Days,
      "pm_Active": pm_Active,
      "pm_Result": 1,
    };
    int contentlength = utf8.encode(json.encode(data)).length;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.paymentdo,
    );
    final response = await http.post(
      url,
      body: msg,
      headers: requestHeaders,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      //  List<Book> collectionListById = [];
      final responsebody = json.decode(response.body) as Map<String, dynamic>;
      if (responsebody['pm_Active'] == true) {
        mybox!.put('pm_Active', pm_Active);
        mybox!.put('pm_RefernceID', pm_RefernceID);
        mybox!.put('Sb_ID', responsebody['Sb_ID']);
        mybox!.put("pm_Price", pm_Price);
        mybox!.put("pm_Days", pm_Days);
        print("payment success");

        // BooksApi().getBooks("en");
      }
    } else {
      // throw Exception();
    }
  }

  String generateDigest(playload) {
    String digest = "";
    String bodyText = "$playload";
    var sha256hash = sha256.convert(utf8.encode(bodyText));
    List<int> payloadBytes = sha256hash.bytes;
    digest = base64.encode(payloadBytes);
    digest = "SHA-256=" + digest;
    return digest;
  }

  String generateSignatureFromParams(String signatureParams, String secretKey) {
    var sigBytes = utf8.encode(signatureParams);
    var decodedSecret = base64.decode(secretKey);
    var hmacSha256 = Hmac(sha256, decodedSecret);
    var messageHash = hmacSha256.convert(sigBytes);
    return base64.encode(messageHash.bytes);
  }

  Date() {
    var dateTime = DateTime.now();
    var val =
        DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", "en_US").format(dateTime);
    return val;
  }
//******************* Function Get GetBanner  ******************//

  Future<void> getBanner() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized = DEFAULT_TOKEN;
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $authorized'
    };
    final url = Uri.parse(
      AppLink.banner,
    );
    final response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // await mybox!.put('getbanner', responsebody);
      List bannerList = [];
      bannerList = json.decode(response.body) as List;

      bannerList.forEach((element) {
        Map? obj = element as Map;
        getbannerList.add(BannerIm(
            bnid: obj['bn_ID'] as String,
            mdid: obj['md_ID'] as String,
            blID: obj['bl_ID'] as String,
            grID: obj['gr_ID'] as String,
            bnTitle: obj['bn_Title'] as String,
            bnTitleAr: obj['bn_Title_Ar'] as String,
            bnDesc: obj['bn_Desc'] as String,
            bnActive: obj['bn_Active'] as bool,
            bnDescAr: obj['bn_Desc_Ar'] as String,
            bnPublishFrom: obj['bn_PublishFrom'] as String,
            bnPublishTill: obj['bn_PublishTill'] as String,
            imagePath:
                "https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/${obj['md_ID']}"));
      });
    } else {
      // throw Exception();
    }
  }

/********************Check if Token is Expired ***************/
  DateTime? tokenExpiryTime;
  bool isTokenExpired() {
    if (tokenExpiryTime == null) return true;
    return DateTime.now().isAfter(tokenExpiryTime!);
  }

  refreshToken(BuildContext context) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? YOUR_REFRESH_TOKEN =
        await sharedPreferences.getString("refreshToken");
    if (YOUR_REFRESH_TOKEN == null || YOUR_REFRESH_TOKEN == "") {
      YOUR_REFRESH_TOKEN = Refresh_TOKEN;
    }
    try {
      final response = await http.post(
        Uri.parse('https://ejaz.applab.qa/api/ejaz/v1/Account/refreshtoken'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'RefreshToken': YOUR_REFRESH_TOKEN}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String? newAccessToken = data['accessToken'];
        String? newRefreshToken = data['refreshToken'];

        if (newAccessToken != null && newRefreshToken != null) {
          // Save new tokens
          await sharedPreferences.setString("authorized", newAccessToken);
          print("newAccessToken1 $newAccessToken");
          await sharedPreferences.setString("refreshToken", newRefreshToken);
          tokenExpiryTime = DateTime.now()
              .add(Duration(days: 1)); // Adjust based on API response

          print("✅ Token refreshed successfully!");
          return;
        } else {
          Get.toNamed(Routes.signin);
        }
      } else {
        String errorValue = await buildHtmlErrorEmail(
          displayName: displayName,
          requestHeaders: {
            'Authorization': 'Bearer $YOUR_REFRESH_TOKEN',
          },
          uri: "Account/refreshtoken",
          responseBody: response.body,
        );
        await handleError(context, errorValue, "refreshToken");
      }
    } catch (error) {
      print("⚠️ Error refreshing token: $error");
      String ErrorValue = "${YOUR_REFRESH_TOKEN},\n${error.toString()}";
      await handleError(context, ErrorValue, "refreshToken");
    }
  }

  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return {};
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }

/********************End Check if Token is Expired ***************/
}

//******************* Function Post Suggest book  ******************//
PostSuggest(String Bk_Code, String Bk_Title, String Bk_Language,
    String Bk_Author, String Bk_Editor, String Bk_Comments, String lang) async {
  late SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();
  String? authorized = sharedPreferences.getString("authorized");
  if (authorized == null || authorized == "") {
    authorized =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q";
  }

  Map<String, String> data = {
    "Bk_Code": Bk_Code,
    "Bk_Title": Bk_Title,
    "Bk_Language": Bk_Language,
    "Bk_Author": Bk_Author,
    "Bk_Editor": Bk_Editor,
    "Bk_Comments": Bk_Comments,
  };
  int contentlength = utf8.encode(json.encode(data)).length;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    //'Accept': 'application/json',
    'Content-Length': '$contentlength',
    //'Host': '0',
    'Authorization': 'Bearer $authorized'
  };
  final msg = jsonEncode(data);
  final url = Uri.parse(
    AppLink.suggest,
  );
  final response = await http.post(
    url,
    headers: requestHeaders,
    body: msg,
  ); //,headers: requestHeaders,

  if (response.statusCode == 200) {
    print('book sent');
    Get.snackbar(
      lang == "en" ? 'Alert' : 'تنبيه',
      lang == "en" ? 'Book sent successful' : 'الكتاب أرسِل بنجاح',
      colorText: Colors.white,
      backgroundColor: Colors.greenAccent,
      icon: const Icon(Icons.sentiment_satisfied_alt),
    );
  } else {
    //  await SendEmailException(response.body, ApiName);
    print('suggest book error');
    Get.snackbar(
      lang == "en" ? 'Alert' : 'تنبيه',
      lang == "en" ? 'Error,Please try again ' : 'خطأ، يرجى المحاولة مرة أخرى',
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.sentiment_satisfied_alt),
    );
    // throw Exception();
  }
}

//******************* Function Post GiftEjaz  ******************//
PostGiftEjaz(
  String fullname,
  String email,
  String typesub,
  String note,
  String lang,
) async {
  if (mybox!.get('PaymentStatus') == 'success') {
    late SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q";
    }

    var pm_Price = mybox!.get("pm_Price") != null ? mybox!.get("pm_Price") : "";
    var pm_Days = mybox!.get("pm_Days") != null ? mybox!.get("pm_Days") : "";
    var pm_RefernceID =
        mybox!.get('pm_RefernceID') != null ? mybox!.get("pm_RefernceID") : "";
    var Sb_ID = mybox!.get('Sb_ID') != null ? mybox!.get("Sb_ID") : "";
    Map<String, String> data = {
      "Py_ID": "1e614759-be5c-4620-98d5-1dd079a120a6",
      "Sb_ID": Sb_ID,
      "PM_Recipient": email,
      "Pm_RefernceID": pm_RefernceID,
      "Pm_DisplayPrice": pm_Days,
      "Pm_Days": pm_Days,
      "Pm_Price": pm_Price,
      "Pm_Result": "1",
      "Pm_Ordinal": "1"
    };
    int contentlength = utf8.encode(json.encode(data)).length;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.giftejaz,
    );
    final response = await http.post(
      url,
      headers: requestHeaders,
      body: msg,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      mybox!.put("pm_Price", '');
      mybox!.put("pm_Days", '');
      mybox!.put('pm_RefernceID', '');
      mybox!.put('Sb_ID', '');
      print('Gift ejaz sent');
      Get.snackbar(
        lang == "en" ? 'Alert' : 'تنبيه',
        lang == "en" ? 'Gift Ejaz sent successful' : 'هدية إيجاز أرسِلت بنجاح',
        colorText: Colors.white,
        backgroundColor: Colors.greenAccent,
        icon: const Icon(Icons.sentiment_satisfied_alt),
      );
    } else {
      //  await SendEmailException(response.body, ApiName);
      print('Gift ejaz error');
      // throw Exception();
      Get.snackbar(
        lang == "en" ? 'Alert' : 'تنبيه',
        lang == "en"
            ? 'Gift payment has error! please try again '
            : 'خطأ في الهدية المدفوعة! حاول مجددًا',
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.info),
      );
    }
  } else {
    Get.snackbar(
      lang == "en" ? 'Alert' : 'تنبيه',
      lang == "en" ? 'Please subscribe first' : 'يرجى الاشتراك أولًا',
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.info),
    );
  }
}

// ignore: always_declare_return_types, inference_failure_on_function_return_type
CloseRawSnakerbar() {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
}

//******************Start function buildHtmlErrorEmail  ***************/
Future<String> buildHtmlErrorEmail({
  required String displayName,
  required Map<String, String> requestHeaders,
  required dynamic uri,
  required dynamic responseBody,
}) async {
  final String html = """
 <html>
    <body style="font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;">
      <h2 style="color: #d9534f;">🚨 API Error Report</h2>

      <p><strong>Message:</strong> An error occurred while processing the request.</p>
      <p><strong>User Name:</strong> $displayName</p>
      <p><strong>Time:</strong> ${DateTime.now()}</p>

      <p><strong>Headers:</strong></p>
      <pre style="background-color:#f1f1f1; padding: 10px; border-radius: 5px;">${requestHeaders.toString()}</pre>

      <p><strong>APis Url:</strong></p>
      <pre style="background-color:#f1f1f1; padding: 10px; border-radius: 5px;">${uri.toString()}</pre>

      <p><strong>Response Body:</strong></p>
      <pre style="background-color:#f1f1f1; padding: 10px; border-radius: 5px;">${responseBody.toString()}</pre>

      <hr style="margin-top: 40px;" />
      <p style="font-style: italic; color: #555;">Best regards,</p>
      <p style="font-weight: bold; color: #333;">Hisni Walid</p>
      <p style="font-weight: bold; color: #333;">Senior Mobile Developer</p>
    </body>
  </html>
  """;

  return html;
}

//******************Start function sendErrorEmail  ***************/

Future<void> sendErrorEmail(String errorDetails, String apisName) async {
  String username = 'downloadejaz@gmail.com'; // Your email
  String password = 'davg vlft zzgi ujid'; // App Password (if using Gmail)

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Ejaz Books')
    ..recipients.add('ejazalerexception@gmail.com') // Admin email
    ..subject = '⚠️ Exception Alert: APIs Name: $apisName ${DateTime.now()}'
    ..html = errorDetails; // This sends the content as HTML

  try {
    final sendReport = await send(message, smtpServer);
    print('Email sent: ${sendReport.toString()}');
  } catch (e) {
    print('Failed to send email: $e');
  }
}
