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
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BooksApi extends ChangeNotifier {
  List books = [];
  List collection = [];
  List collectionByAu = [];
  bool isLooding = true;

//******************* Function getbooks ******************//

  void getBooks(String lang) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      // 'Accept': 'application/json',
      //'Content-Length': '$contentlength',
      'Authorization': 'Bearer $authorized',
    };
    final url = Uri.parse(
      AppLink.getbook,
    );
    final response = await http.get(
      url,
      headers: requestHeaders,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      mockBookList = [];
      books = json.decode(response.body) as List;
      var i = 0;
      books.forEach((element) {
        Map? obj = element as Map;
        List categories = obj['categories'] as List;
        List authors = obj['authors'] as List;
        List tags = obj['tags'] as List;
        List genres = obj['genres'] as List;
        List publishers = obj['publishers'] as List;
        List thematicAreas = obj['thematicAreas'] as List;
        List media = obj['media'] as List;
        String image;
        if (media.length > 0) {
          image = media[0]['md_URL'] != null //md_ID
              ? media[0]['md_URL'] as String //md_ID
              : "5337aa5b-949b-4dd2-8563-08db749b866d";
        } else {
          image = '5337aa5b-949b-4dd2-8563-08db749b866d';
        }

        //**** get audio    *////
        String audioEn = obj['md_AudioEn_URL'] != null //md_AudioEn_ID
            ? obj['md_AudioEn_URL'] as String //md_AudioEn_ID
            : Const.UrlAu;

        String audioAr = obj['md_AudioAr_URL'] != null //md_AudioAr_ID
            ? obj['md_AudioAr_URL'] as String //md_AudioAr_ID
            : Const.UrlAu;

        mockBookList.add(
          Book(
            bk_ID: obj['bk_ID'] as String, //as String
            bk_Code: obj['bk_Code'] as String,
            bk_Name: obj['bk_Name'] == 'N/A'
                ? obj['bk_Name_Ar'] as String
                : obj['bk_Name'] != null
                    ? obj['bk_Name'] as String
                    : "",
            bk_Name_Ar:
                obj['bk_Name_Ar'] != null ? obj['bk_Name_Ar'] as String : "",
            bk_Introduction: obj['bk_Introduction'] == 'N/A'
                ? obj['bk_Introduction_Ar'] as String
                : obj['bk_Introduction'] != null
                    ? obj['bk_Introduction'] as String
                    : "",
            bk_Introduction_Ar: obj['bk_Introduction_Ar'] != null
                ? obj['bk_Introduction_Ar'] as String
                : "",
            bk_Summary: obj['bk_Summary'] == 'N/A'
                ? obj['bk_Summary_Ar'] as String
                : obj['bk_Summary'] != null
                    ? obj['bk_Summary'] as String
                    : "",
            bk_Summary_Ar: obj['bk_Summary_Ar'] != null
                ? obj['bk_Summary_Ar'] as String
                : "",
            bk_Characters: obj['bk_Characters'] == 'N/A'
                ? obj['bk_Characters_Ar'] as String
                : obj['bk_Characters'] != null
                    ? obj['bk_Characters'] as String
                    : "",
            bk_Characters_Ar: obj['bk_Characters_Ar'] != null
                ? obj['bk_Characters_Ar'] as String
                : "",
            bk_Desc: obj['bk_Desc'] == 'N/A'
                ? obj['bk_Desc_Ar'] as String
                : obj['bk_Desc'] != null
                    ? obj['bk_Desc'] as String
                    : "",
            bk_Desc_Ar:
                obj['bk_Desc_Ar'] != null ? obj['bk_Desc_Ar'] as String : "",
            bk_Language: obj['bk_Language'] == 'N/A'
                ? obj['bk_Language_ Ar'] as String
                : obj['bk_Language'] != null
                    ? obj['bk_Language'] as String
                    : "",
            bk_Language_Ar: obj['bk_Language_Ar'] != null
                ? obj['bk_Language_Ar'] as String
                : "",
            bk_Active: obj['bk_Active'] as bool,
            bk_CreatedOn: obj['bk_CreatedOn'] as String,
            bk_trial: obj['bk_Trial'] as bool,
            // bk_Modifier: obj['bk_Modifier'] as String,
            audioEn: audioEn,
            //'https://ejaz.applab.qa/api/ejaz/v1/Medium/getAudio/$audioEn',
            audioAr: audioAr,
            // 'https://ejaz.applab.qa/api/ejaz/v1/Medium/getAudio/$audioAr',
            imagePath: image,
            //'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image', //obj['media'] as String,
            categories: categories,
            authors: authors,
            tags: tags,
            genres: genres,
            publishers: publishers,
            thematicAreas: thematicAreas,
          ),
        );
        i + 1;
        this.isLooding = false;
        notifyListeners();
      });
    } else {
      this.isLooding = true;
      books = mockBookList;
      notifyListeners();

      Get.snackbar(
        lang == "en" ? 'Alert' : 'تنبيه',
        lang == "en"
            ? "We'll be back soon! Server under maintaince"
            : "سنعود قريبا! الخادم تحت الصيانة",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        icon: const Icon(Icons.sentiment_dissatisfied),
      );
      // await SendEmailException(response.body, ApiName);
      //throw Exception();
    }
    // return books
    //     .map((json) => Book.fromJson(json as Map<String, dynamic>))
    //     .toList();
  }

//******************* Function getCategory ******************//

  getCategory() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
    }

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
      //  await SendEmailException(response.body, ApiName);
      //throw Exception();
    }
  }

//************* getAauthors   ************************* */
  void getAuthors() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
    }

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
    } else {
      //  await SendEmailException(response.body, ApiName);
      // throw Exception();
    }
  }

  //************* getAauthors   ************************* */
  getAuthorsbyCollections(String id) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
    }

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
      //  await SendEmailException(response.body, ApiName);
      // throw Exception();
    }
  }

//******************* Function SignupGoogleApple  ******************//

  SignupGoogleApple(
      String username, String? email, String? FirebaseUID, String type) async {
    var uid = Uuid().v4();
    // ignore: omit_local_variable_types
    Map<String, String> data = {
      "FirebaseUID": FirebaseUID!,
      "FirebaseToken": "dfgdfg",
      "DisplayName": type == 'google' ? username : email as String,
      "Username": type == 'google'
          ? username + "@" + uid.split('-')[0]
          : email as String,
      "Password": 'GoogleApple@12345',
      "Email": email!,
      "PhoneNumber": FirebaseUID,
      "Language": "All",
    };
    // ignore: prefer_final_locals
    int contentlength = utf8.encode(json.encode(data)).length;

    // ignore: omit_local_variable_types
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      // 'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.signup,
    );
    final response = await http.post(url,
        headers: requestHeaders, body: msg); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final responsebody = json.decode(response.body) as Map<String, dynamic>;
      await mybox!.put('islogin', true);
      if (responsebody['isSubscribed'] == true) {
        mybox!.put('PaymentStatus', 'success');
        await sharedPreferences.setString(
            'name', responsebody['displayName'] as String);
        await sharedPreferences.setString(
            "authorized", responsebody['token'] as String);
        await sharedPreferences.setString(
            "image", responsebody['image'] as String);
        /********************Start Firebase generate token *********************/
        await FirebaseMessaging.instance.getToken().then((value) {
          print(value);
          String? token = value;
          sharedPreferences.setString('token', token!);
          UpdateFirebaseToken(token);
        });

        /********************End Firebase generate token *********************/

        await Get.offAllNamed(Routes.home, arguments: "");
      } else if (responsebody['isSubscribed'] == false) {
        mybox!.put('PaymentStatus', 'pending');

        await sharedPreferences.setString(
            'name', responsebody['displayName'] as String);
        await sharedPreferences.setString(
            "authorized", responsebody['token'] as String);
        await sharedPreferences.setString(
            "image", responsebody['image'] as String);
        /********************Start Firebase generate token *********************/
        await FirebaseMessaging.instance.getToken().then((value) {
          print(value);
          String? token = value;
          sharedPreferences.setString('token', token!);
          UpdateFirebaseToken(token);
        });

        /********************End Firebase generate token *********************/

        await Get.offAllNamed(Routes.home, arguments: "");
      }
    } else {
      print("response  ${response.body}");
      // await SendEmailException(response.body, ApiName);
      Get.rawSnackbar(
          messageText: const Text('User Name or Email Exist!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: ColorLight.primary,
          icon: const Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    }
  }

  //******************* Function Get Subscription  ******************//

  void GetSubscription() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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
    }
  }
  //******************* Function Get EjazCollection  ******************//

  void GetEjazCollection() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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
    } else {
      //  await SendEmailException(response.body, ApiName);
    }
  }

  //******************* Function Get EjazCollectionById  ******************//
  void GetEjazCollectionById(id) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      // 'Content-Length': '$contentlength',
      //'Host': '0',
      'Authorization': 'Bearer $authorized'
    };
    final url = Uri.parse(
      'https://ejaz.applab.qa/api/ejaz/v1/BookCollection/getBookCollection/$id',
    );
    final response = await http.get(
      url,
      headers: requestHeaders,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      //  List<Book> collectionListById = [];
      collectionListById = [];
      Map responsecollection = {};
      responsecollection = json.decode(response.body) as Map;
      var i = 0;
      responsecollection['books'].forEach((element) {
        Map? obj = element as Map;
        String image = responsecollection['md_ID'] as String;
        collectionListById.add(Book(
          bk_ID: obj['bk_ID'] as String,
          bk_Name: responsecollection['bc_Title'] as String,
          bk_Name_Ar: responsecollection['bc_Title_Ar'] as String,
          imagePath:
              'https://ejaz.applab.qa/api/ejaz/v1/Medium/getImage/$image',
          audioAr: '',
          audioEn: '',
          authors: [],
          categories: [],
          genres: [],
          publishers: [],
          tags: [],
          thematicAreas: [],
        ));
        i + 1;
      });

      await Get.toNamed<dynamic>(Routes.collection,
          arguments: collectionListById);
    } else {
      //await SendEmailException(response.body, ApiName);
      // throw Exception();
    }
  }

  //******************* Function Get UpdateProfiles  ******************//
  void UpdateProfiles(fullname, country, gender, bio) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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

  //******************* Function Get Checklogin  ******************//
// ignore_for_file: prefer_const_constructors
  CheckLogin(type, value, uid, displayName) async {
    print("type, value, uid, displayName $type, $value, $uid, $displayName");

    Map<String, String> data = {
      "email": type == 'google' ? value as String : "",
      "phoneNumber": type == 'phoneNumber' ? value as String : "",
      "username": type == 'apple' ? value as String : "",
    };
    int contentlength = utf8.encode(json.encode(data)).length;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      // 'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.checklogin,
    );
    final response = await http.post(
      url,
      headers: requestHeaders,
      body: msg,
    ); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      print("checklogin ${response.body}");
      if (response.body != "true") {
        await SignupGoogleApple(displayName as String, value as String,
            uid as String, type as String);
      } else {
        await SignGoogleApple(value as String, type as String);
      }
    } else {
      //String ApiName = "checklogin";
      //  await SendEmailException(response.body, ApiName);
      Get.rawSnackbar(
          messageText: const Text('Failed to connect !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: ColorLight.primary,
          icon: const Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
      // throw Exception();
    }
  }

//******************* Function SignupGoogleApple  ******************//

  SignGoogleApple(String email, String type) async {
    // ignore: omit_local_variable_types
    Map<String, String> data = {
      "Password": 'GoogleApple@12345',
      "Email": email,
    };
    // ignore: prefer_final_locals
    int contentlength = utf8.encode(json.encode(data)).length;

    // ignore: omit_local_variable_types
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Content-Length': '$contentlength',
      //'Host': '0',
      // 'Authorization': 'Bearer $authorized'
    };
    final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.login,
    );
    final response = await http.post(url,
        headers: requestHeaders, body: msg); //,headers: requestHeaders,

    if (response.statusCode == 200) {
      print('Login successful');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final responsebody = json.decode(response.body) as Map<String, dynamic>;
      if (responsebody['isSubscribed'] == true) {
        await prefs.setString('name', responsebody['displayName'] as String);
        await prefs.setString("authorized", responsebody['token'] as String);
        await prefs.setString("image", responsebody['image'] as String);

        await FirebaseMessaging.instance.getToken().then((value) {
          print(value);
          String? token = value;
          prefs.setString('token', token!);
          UpdateFirebaseToken(token);
        });
        await mybox!.put('PaymentStatus', 'success');

        await Get.offNamed(Routes.home);
      }
      if (responsebody['isSubscribed'] == false) {
        await prefs.setString('name', responsebody['displayName'] as String);
        await prefs.setString("authorized", responsebody['token'] as String);
        await prefs.setString("image", responsebody['image'] as String);

        await FirebaseMessaging.instance.getToken().then((value) {
          print(value);
          String? token = value;
          prefs.setString('token', token!);
          UpdateFirebaseToken(token);
        });
        await mybox!.put('PaymentStatus', 'pending');

        await Get.offNamed(Routes.home);
      }
    } else {
      Get.rawSnackbar(
          messageText: const Text('Login Failed ... try again',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: ColorLight.primary,
          icon: const Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    }
  }

  //******************* Function Get EjazCollectionById  ******************//
  PaymentPost(
      String pm_RefernceID, int pm_Price, int pm_Days, bool pm_Active) async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString('authorized');
    if (authorized == null || authorized == '') {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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
        BooksApi().getBooks("en");
      }
    } else {
      // throw Exception();
    }
  }

  //******************* Function Post Payment Apple Google  ******************//
  PaymentPostApple(final token, final payresult) async {
    String encoded = base64.encode(utf8.encode(token));
    final adress1 = payresult['billingContact']['postalAddress']['street'];
    final locality = payresult['billingContact']['postalAddress']['locality'];
    final countryCode =
        payresult['billingContact']['postalAddress']['isoCountryCode'];
    final postalCode =
        payresult['billingContact']['postalAddress']['postalCode'];
    final firstname = payresult['billingContact']['name']['givenName'];
    final lastname = payresult['billingContact']['name']['familyName'];
    final administrativeArea =
        payresult['billingContact']['postalAddress']['administrativeArea'];
    final clientReferenceInformation = payresult['transactionIdentifier'];
    print(encoded);
    Map<String, dynamic> data = {
      "clientReferenceInformation": {"code": clientReferenceInformation},
      "processingInformation": {"paymentSolution": "001"},
      "paymentInformation": {
        "fluidData": {
          "value": "$encoded",
          "descriptor": "RklEPUNPTU1PTi5BUFBMRS5JTkFQUC5QQVlNRU5U",
          "encoding": "Base64",
        },
        "tokenizedCard": {"type": "002", "transactionType": "1"}
      },
      "orderInformation": {
        "amountDetails": {"totalAmount": "7", "currency": "USD"},
        "billTo": {
          "firstName": firstname,
          "lastName": lastname,
          "address1": adress1,
          "locality": locality,
          "administrativeArea": administrativeArea,
          "postalCode": postalCode,
          "country": countryCode,
          "email": "ejazapp@hbku.edu.qa"
        }
      }
    };
    int contentlength = utf8.encode(json.encode(data)).length;
    final msg = jsonEncode(data);
    String dateTran = Date();
    String digest = generateDigest(msg);
    var SignatureParm =
        "host: apitest.cybersource.com v-c-date: $dateTran request-target digest: $digest v-c-merchant-id: hbkupress_1723456353";
    String signature = generateSignatureFromParams(
        SignatureParm, "ziE1E4LmkcMK2tnwM+q3GYsG4SvZakNfbvKF0oCBV2Q=");
    Map<String, String> requestHeaders = {
      // "authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsInYtYy1tZXJjaGFudC1pZCI6InRlc3RyZXN0IiwieDVjIjpbIk1JSUNYekNDQWNpZ0F3SUJBZ0lXTnpFNE1UWXhOalV5TXpVeU1ERTNOekV3TnpBME56QU5CZ2txaGtpRzl3MEJBUXNGQURBZU1Sd3dHZ1lEVlFRRERCTkRlV0psY2xOdmRYSmpaVU5sY25SQmRYUm9NQjRYRFRJME1EWXhNakF6TURjek1sb1hEVEkyTURZeE1qQXpNRGN6TWxvd05ERVJNQThHQTFVRUF3d0lkR1Z6ZEhKbGMzUXhIekFkQmdOVkJBVVRGamN4T0RFMk1UWTFNak0xTWpBeE56Y3hNRGN3TkRjd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUNsNUtSazN4UDVNRnRyV3FDbFg1cFBLeElBSHU1SXowTGJZYjFVRTJhZnAvQ2xSU1RJaUdNa2oxNCt3NVBkTlF3NE5ndWliYkZYaWhBUW9uS0ozS1hrWjB1SkE0c24rdmpBS2w0a2RsUWxzNGYxL3prWU1TVkE4WXFJZ3R1bDFOVHArRWNnRDV2R1ZkTnVra0JTR0dIbjJjSEZ5U2ZIZE9nVE0yRFJnTW5vQU10cnI2MHlyRmJ0TE9xSk5EMWcyQ1hBNUltUFU3M2xlVWhRRW5FZTdIUkl5VHgwN3lyVDc1QkJFNWc1cE50d2RNRCtlMVM1bDFtSXRqV2t3MkNRMFRmWlFXcEtkK1ZzNzBWOGF2a24wd1hQYldJMFdsMGlPcktxMytoMkJVRUFPM1N6U1FHUUNsTHR2L3ZyNXBHdmNBWHNjMTBOYnc4Q0J3T1hwSVJWNVBacEFnTUJBQUV3RFFZSktvWklodmNOQVFFTEJRQURnWUVBWmRZcS9YWmRkVVUzU1pKdnFvOHRlQVovZkZoQXdQdDBudUNRRStpR0hVWGVDZjYvRmd3MlJpYTF4dmVaMWZyUGtvaGpmVHhuY21PNkthbC9MSnNkTUpuczZ0ZVh5WTNvdi81bldOMmsySGZhZzhMZXlNZE5QTUJJTzFGeENIUTRJdDE5QXdKdkVBMmo1TXBtWGkxSmlYMGlONElwKyt4NUYwSW9vQ1BRSjdBPSJdfQ==.eyJkaWdlc3QiOiIxd2s1SGxzMXFjYlp0allEbGRHeWwzQjJpOTJ2NHJPcVh5eDZ0d1Jib0VzPSIsImRpZ2VzdEFsZ29yaXRobSI6IlNIQS0yNTYiLCJpYXQiOiJTdW4sIDA4IFNlcCAyMDI0IDA2OjQyOjE5IEdNVCJ9.lfmp7iyzIK2JMRzBbutmreqoGgMpdMySNaGDtQ8SR7BsZZPjJW36j+mJVne/HD0KH3Q05O+YE08EyMSemc2/B5WYeKyFV0QiBAYTHw9uFfw/j65so0bJBdMqZd7qrCX5C6f3UKAtndX0E7FrxlFjjAPDMeJpLD+DsHmT8JzXeLMwujkJDCe9U2StH/DVN5m7k2rDeXgwyWxVMM+Jjhpd7OXjqwpa7bIoMfojNVpAbCA7Cf5ZBibgyVaFuhl/8wlJyW5re1jp8MqZrP2KmOBUix5FLlS4Tel5jityJHQ5GQjx0EP++tBSaHYbPopvWlaH8lywSV7l2xFv4QoahKcS/g==",

      'host': 'apitest.cybersource.com',
      "v-c-date": dateTran,
      "digest": digest,
      'v-c-merchant-id': 'hbkupress_1723456353',
      // 'authorization': 'Bearer $encoded',
      "signature":
          'keyid="74b2fd80-779a-446a-a9a7-b2b55029cca4", algorithm="HmacSHA256", headers="host v-c-date request-target digest v-c-merchant-id", signature="$signature"',
      "Content-Type": "application/json",
      "Content-Length": "$contentlength",
      "Accept-Encoding": "gzip",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    // final msg = jsonEncode(data);
    Map<String, String> requestHeadersToken = {
      "authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsInYtYy1tZXJjaGFudC1pZCI6Imhia3VwcmVzc18xNzIzNDU2MzUzIiwieDVjIjpbIk1JSUNhekNDQWRTZ0F3SUJBZ0lXTnpJMU56Y3pOVEl4T0RVd01ERTNOekV3TnpBME56QU5CZ2txaGtpRzl3MEJBUXNGQURBZU1Sd3dHZ1lEVlFRRERCTkRlV0psY2xOdmRYSmpaVU5sY25SQmRYUm9NQjRYRFRJME1Ea3dPREExTXpJd01Wb1hEVEkyTURrd09EQTFNekl3TVZvd1FERWRNQnNHQTFVRUF3d1VhR0pyZFhCeVpYTnpYekUzTWpNME5UWXpOVE14SHpBZEJnTlZCQVVURmpjeU5UYzNNelV5TVRnMU1EQXhOemN4TURjd05EY3dnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDOVJNcHFqcGtDL0VKSExuVHNROEhSNFZaV2VzMjJKL2hSV0RKU21TSnFQUUhVL0xCS1crclFMeWhkK29vZk83ejFPSVlBdHAvbXFTOFN0N2VOdFpDRnVPdHhrRVZSL1ZLT3QwT1pGU1puWWNBNEl2L21KSzFBdnJuL3ZKS2NRQlY2OGpsSDY2N2RpQi9iazFBYWdvcXZiWFJ1bFNXS1R4bkQ3SFA2YkNwQ0gvbXJ3ejVMUjNjaVYyMG1qSmMvQUxEMktKNVRuQmpRV3JTTG42d2NyZ3dhR2lVK1BTWk1ERE1DRkw3ZStKZlBTb0ZUVEpXSFd0QkRpY2JYVFFSazF2VEFzN3BGOVkyKzE2Y1R6b01oWWlUcVRQRmJGYkVwa0w2ZDBUSkZPWEJkMmk2eHlxYlI5MDFyN29lUW40R2NhaldnaWhEVEhLdUxXUGl1WTNscU1YcExBZ01CQUFFd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ1lFQXRWdHordDRMTDJER0ZGcHdCTmhwVUp2UzJjS3h4bngwVlFEWWluNFo3aGlwdFdNQXNLVVJzVVV2YVpPbGtoL1pnazd5YkJNQUxXdmhqZitDdGhsOHRXNSsyeFlzdGNpZG0zUURKQURHa0NmZEVwa2QwQWV6ZFo0Tk1yRTFxOSszak00ZlZ6T0sxSUw3OFBhZDQ4U01NTHRFYmlEam91MnFxZFNFRHRjWEZnaz0iXX0=.eyJkaWdlc3QiOiIxd2s1SGxzMXFjYlp0allEbGRHeWwzQjJpOTJ2NHJPcVh5eDZ0d1Jib0VzPSIsImRpZ2VzdEFsZ29yaXRobSI6IlNIQS0yNTYiLCJpYXQiOiJUdWUsIDEwIFNlcCAyMDI0IDExOjAzOjU0IEdNVCJ9.gmeRxKotNCttlIITz56mUTW/jZflwo+vBOTkAiioYBRxY7pFNGnWJY4qwQPZMoVKW2Ox8EhHHAASKBqMWmND9LRNqWmYsFMzTwCZvQrRjrhNl2lXooYKxn13xQknRi7exxhH+d1dHBjnJ7RDVQDKOo+34YRJpwlJU/hsqXgRFGRtJ3N2jwovSfY3muevjCGwH2xpTumTCeYu+UlIgJutzseRI+v2cO5KiVQZhawYGb4H9WIULbSKkj1raHwOdoHlWUfED466NZ1Jzz845miW/BIw98fZzMj5BlhbBNpd+IIvA10ICknFlW9ZjsO5p71jop+PPBQXFpjC06PXyFbBlA==",
      "host": "apitest.cybersource.com",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          'true', // Required for cookies, authorization headers with HTTPS
    };
    final url = Uri.parse(
      AppLink.PaymentAppleGooglleTest,
    );
    final response = await http.post(
      url,
      body: msg,
      headers: requestHeadersToken, //requestHeaders,
    ); //,headers: requestHeaders,
    print('signature+++++++++++++++++$signature');
    print('requestHeaders+++++++++++++++++$requestHeaders');
    print('msg+++++++++++++++++$msg');
    print('token+++++++++++++++++$token');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print("payment success");
      Get.toNamed(Routes.thankyou, arguments: ['success']);
    } else {
      print("payment Failed");
      Get.toNamed(Routes.thankyou, arguments: ['failed']);
    }
  }

//******************* Function Post Payment Apple Google  ******************//
  PaymentPostGoogle(final token, final payresult) async {
    String encoded = base64.encode(utf8.encode(token));
    // final String adress1 =
    //     payresult['paymentMethodData']['info']['billingAddress']['address1'];
    // final String locality =
    //     payresult['paymentMethodData']['info']['billingAddress']['locality'];
    // final String countryCode =
    //     payresult['paymentMethodData']['info']['billingAddress']['countryCode'];
    // final String postalCode =
    //     payresult['paymentMethodData']['info']['billingAddress']['postalCode'];
    // final String name =
    //     payresult['paymentMethodData']['info']['billingAddress']['name'];
    // final String administrativeArea = payresult['paymentMethodData']['info']
    //     ['billingAddress']['administrativeArea'];

    print(encoded);
    Map<String, dynamic> data = {
      "clientReferenceInformation": {"code": "TC50171_3"},
      "paymentInformation": {
        "card": {
          "number": "4111111111111111",
          "expirationMonth": "12",
          "expirationYear": "2031"
        }
      },
      "orderInformation": {
        "amountDetails": {"totalAmount": "102.21", "currency": "USD"},
        "billTo": {
          "firstName": "John",
          "lastName": "Doe",
          "address1": "1 Market St",
          "locality": "san francisco",
          "administrativeArea": "CA",
          "postalCode": "94105",
          "country": "US",
          "email": "test@cybs.com",
          "phoneNumber": "4158880000"
        }
      }

      // "processingInformation": {"paymentSolution": "012"},
      // "paymentInformation": {
      //   "fluidData": {"value": "$encoded"}
      // },
      // "orderInformation": {
      //   "amountDetails": {"totalAmount": "7", "currency": "USD"},
      //   "billTo": {
      //     "firstName": name != "" ? name.split(' ')[0] : "",
      //     "lastName": name != "" ? name.split(' ')[1] : "",
      //     "address1": adress1,
      //     "locality": locality,
      //     "administrativeArea": administrativeArea,
      //     "postalCode": postalCode,
      //     "country": countryCode,
      //     "email": "ejazapp@hbku.edu.qa"
      //   }
      // }
    };
    int contentlength = utf8.encode(json.encode(data)).length;
    final msg = jsonEncode(data);
    String dateTran = Date();
    String digest = await generateDigest(msg);
    var SignatureParm =
        "host: apitest.cybersource.com v-c-date: $dateTran request-target digest: $digest v-c-merchant-id: hbkupress_1723456353";
    String signature = await generateSignatureFromParams(
        SignatureParm, "ziE1E4LmkcMK2tnwM+q3GYsG4SvZakNfbvKF0oCBV2Q=");
    // Map<String, String> requestHeaders = {
    //   // "authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsInYtYy1tZXJjaGFudC1pZCI6InRlc3RyZXN0IiwieDVjIjpbIk1JSUNYekNDQWNpZ0F3SUJBZ0lXTnpFNE1UWXhOalV5TXpVeU1ERTNOekV3TnpBME56QU5CZ2txaGtpRzl3MEJBUXNGQURBZU1Sd3dHZ1lEVlFRRERCTkRlV0psY2xOdmRYSmpaVU5sY25SQmRYUm9NQjRYRFRJME1EWXhNakF6TURjek1sb1hEVEkyTURZeE1qQXpNRGN6TWxvd05ERVJNQThHQTFVRUF3d0lkR1Z6ZEhKbGMzUXhIekFkQmdOVkJBVVRGamN4T0RFMk1UWTFNak0xTWpBeE56Y3hNRGN3TkRjd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUUNsNUtSazN4UDVNRnRyV3FDbFg1cFBLeElBSHU1SXowTGJZYjFVRTJhZnAvQ2xSU1RJaUdNa2oxNCt3NVBkTlF3NE5ndWliYkZYaWhBUW9uS0ozS1hrWjB1SkE0c24rdmpBS2w0a2RsUWxzNGYxL3prWU1TVkE4WXFJZ3R1bDFOVHArRWNnRDV2R1ZkTnVra0JTR0dIbjJjSEZ5U2ZIZE9nVE0yRFJnTW5vQU10cnI2MHlyRmJ0TE9xSk5EMWcyQ1hBNUltUFU3M2xlVWhRRW5FZTdIUkl5VHgwN3lyVDc1QkJFNWc1cE50d2RNRCtlMVM1bDFtSXRqV2t3MkNRMFRmWlFXcEtkK1ZzNzBWOGF2a24wd1hQYldJMFdsMGlPcktxMytoMkJVRUFPM1N6U1FHUUNsTHR2L3ZyNXBHdmNBWHNjMTBOYnc4Q0J3T1hwSVJWNVBacEFnTUJBQUV3RFFZSktvWklodmNOQVFFTEJRQURnWUVBWmRZcS9YWmRkVVUzU1pKdnFvOHRlQVovZkZoQXdQdDBudUNRRStpR0hVWGVDZjYvRmd3MlJpYTF4dmVaMWZyUGtvaGpmVHhuY21PNkthbC9MSnNkTUpuczZ0ZVh5WTNvdi81bldOMmsySGZhZzhMZXlNZE5QTUJJTzFGeENIUTRJdDE5QXdKdkVBMmo1TXBtWGkxSmlYMGlONElwKyt4NUYwSW9vQ1BRSjdBPSJdfQ==.eyJkaWdlc3QiOiIxd2s1SGxzMXFjYlp0allEbGRHeWwzQjJpOTJ2NHJPcVh5eDZ0d1Jib0VzPSIsImRpZ2VzdEFsZ29yaXRobSI6IlNIQS0yNTYiLCJpYXQiOiJTdW4sIDA4IFNlcCAyMDI0IDA2OjQyOjE5IEdNVCJ9.lfmp7iyzIK2JMRzBbutmreqoGgMpdMySNaGDtQ8SR7BsZZPjJW36j+mJVne/HD0KH3Q05O+YE08EyMSemc2/B5WYeKyFV0QiBAYTHw9uFfw/j65so0bJBdMqZd7qrCX5C6f3UKAtndX0E7FrxlFjjAPDMeJpLD+DsHmT8JzXeLMwujkJDCe9U2StH/DVN5m7k2rDeXgwyWxVMM+Jjhpd7OXjqwpa7bIoMfojNVpAbCA7Cf5ZBibgyVaFuhl/8wlJyW5re1jp8MqZrP2KmOBUix5FLlS4Tel5jityJHQ5GQjx0EP++tBSaHYbPopvWlaH8lywSV7l2xFv4QoahKcS/g==",

    //   'host': 'apitest.cybersource.com',
    //   "v-c-date": dateTran,
    //   "digest": digest,
    //   'v-c-merchant-id': 'hbkupress_1723456353',
    //   // 'authorization': 'Bearer $encoded',
    //   "signature":
    //       'keyid="74b2fd80-779a-446a-a9a7-b2b55029cca4", algorithm="HmacSHA256", headers="host v-c-date request-target digest v-c-merchant-id", signature="$signature"',
    //   "Content-Type": "application/json",
    //   // "Content-Length": "$contentlength",
    // };
    Map<String, String> requestHeadersToken = {
      "authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsInYtYy1tZXJjaGFudC1pZCI6Imhia3VwcmVzc18xNzIzNDU2MzUzIiwieDVjIjpbIk1JSUNhekNDQWRTZ0F3SUJBZ0lXTnpJMU56Y3pOVEl4T0RVd01ERTNOekV3TnpBME56QU5CZ2txaGtpRzl3MEJBUXNGQURBZU1Sd3dHZ1lEVlFRRERCTkRlV0psY2xOdmRYSmpaVU5sY25SQmRYUm9NQjRYRFRJME1Ea3dPREExTXpJd01Wb1hEVEkyTURrd09EQTFNekl3TVZvd1FERWRNQnNHQTFVRUF3d1VhR0pyZFhCeVpYTnpYekUzTWpNME5UWXpOVE14SHpBZEJnTlZCQVVURmpjeU5UYzNNelV5TVRnMU1EQXhOemN4TURjd05EY3dnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDOVJNcHFqcGtDL0VKSExuVHNROEhSNFZaV2VzMjJKL2hSV0RKU21TSnFQUUhVL0xCS1crclFMeWhkK29vZk83ejFPSVlBdHAvbXFTOFN0N2VOdFpDRnVPdHhrRVZSL1ZLT3QwT1pGU1puWWNBNEl2L21KSzFBdnJuL3ZKS2NRQlY2OGpsSDY2N2RpQi9iazFBYWdvcXZiWFJ1bFNXS1R4bkQ3SFA2YkNwQ0gvbXJ3ejVMUjNjaVYyMG1qSmMvQUxEMktKNVRuQmpRV3JTTG42d2NyZ3dhR2lVK1BTWk1ERE1DRkw3ZStKZlBTb0ZUVEpXSFd0QkRpY2JYVFFSazF2VEFzN3BGOVkyKzE2Y1R6b01oWWlUcVRQRmJGYkVwa0w2ZDBUSkZPWEJkMmk2eHlxYlI5MDFyN29lUW40R2NhaldnaWhEVEhLdUxXUGl1WTNscU1YcExBZ01CQUFFd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ1lFQXRWdHordDRMTDJER0ZGcHdCTmhwVUp2UzJjS3h4bngwVlFEWWluNFo3aGlwdFdNQXNLVVJzVVV2YVpPbGtoL1pnazd5YkJNQUxXdmhqZitDdGhsOHRXNSsyeFlzdGNpZG0zUURKQURHa0NmZEVwa2QwQWV6ZFo0Tk1yRTFxOSszak00ZlZ6T0sxSUw3OFBhZDQ4U01NTHRFYmlEam91MnFxZFNFRHRjWEZnaz0iXX0=.eyJkaWdlc3QiOiIxd2s1SGxzMXFjYlp0allEbGRHeWwzQjJpOTJ2NHJPcVh5eDZ0d1Jib0VzPSIsImRpZ2VzdEFsZ29yaXRobSI6IlNIQS0yNTYiLCJpYXQiOiJUdWUsIDEwIFNlcCAyMDI0IDExOjAzOjU0IEdNVCJ9.gmeRxKotNCttlIITz56mUTW/jZflwo+vBOTkAiioYBRxY7pFNGnWJY4qwQPZMoVKW2Ox8EhHHAASKBqMWmND9LRNqWmYsFMzTwCZvQrRjrhNl2lXooYKxn13xQknRi7exxhH+d1dHBjnJ7RDVQDKOo+34YRJpwlJU/hsqXgRFGRtJ3N2jwovSfY3muevjCGwH2xpTumTCeYu+UlIgJutzseRI+v2cO5KiVQZhawYGb4H9WIULbSKkj1raHwOdoHlWUfED466NZ1Jzz845miW/BIw98fZzMj5BlhbBNpd+IIvA10ICknFlW9ZjsO5p71jop+PPBQXFpjC06PXyFbBlA==",
      "host": "apitest.cybersource.com",
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-Length": "$contentlength",
      "cache-control": "no-cache, no-store, must-revalidate"
    };

    // final msg = jsonEncode(data);
    final url = Uri.parse(
      AppLink.PaymentAppleGooglleTest,
    );

    print("header $requestHeadersToken");
    final response = await http.post(
      url,
      body: msg,
      headers:
          requestHeadersToken, //base64.encode(utf8.encode('$requestHeadersToken')) , //requestHeaders,
    ); //,headers: requestHeaders,
    print('${response.body}  ${response.statusCode}');
    if (response.statusCode == 201) {
      print("payment success");
      Get.toNamed(Routes.thankyou, arguments: ['success']);
    } else {
      print("payment Failed");
      Get.toNamed(Routes.thankyou, arguments: ['failed']);
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

  void getBanner() async {
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String? authorized = sharedPreferences.getString("authorized");
    if (authorized == null || authorized == "") {
      authorized =
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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
}

//******************* Function Post Suggest book  ******************//
PostSuggest(String Bk_Code, String Bk_Title, String Bk_Language,
    String Bk_Author, String Bk_Editor, String Bk_Comments, String lang) async {
  late SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();
  String? authorized = sharedPreferences.getString("authorized");
  if (authorized == null || authorized == "") {
    authorized =
        'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InNoYWhyYXouaUBvdXRsb29rLmNvbSIsIm5hbWVpZCI6IjUxN2Q3NmQ2LTg4MTYtNDljNS05YWU0LTM0YWFmNzQ3YmMxZCIsImVtYWlsIjoic2hhaHJhei5pQG91dGxvb2suY29tIiwibmJmIjoxNjkwNzM5NzYzLCJleHAiOjE2OTEzNDQ1NjMsImlhdCI6MTY5MDczOTc2M30.ox73qA-VWGjc2xJwYHEgDyWA031L6k4wh7t0KotIhhK0LMsVRYrf5ZS28ocRtd3HWo2idxgNzPKOzyAmFFAG0Q';
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

