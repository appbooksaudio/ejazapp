// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ejazapp/providers/locale_provider.dart';
// import 'package:ejazapp/l10n/app_localizations.dart';

// import 'package:ejazapp/data/models/audio.dart';
// import 'package:ejazapp/data/models/book.dart';
// import 'package:ejazapp/data/models/playlist.dart';
// import 'package:ejazapp/helpers/colors.dart';
// import 'package:ejazapp/helpers/routes.dart';
// import 'package:ejazapp/providers/audio_provider.dart';
// import 'package:ejazapp/providers/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:octo_image/octo_image.dart';
// import 'package:provider/provider.dart';

// class AddAudioPlay extends StatefulWidget {
//   const AddAudioPlay({super.key});

//   @override
//   State<AddAudioPlay> createState() => _AddAudioPlayState();
// }

// class _AddAudioPlayState extends State<AddAudioPlay> {
//   PlayList? play1;
//   bool isUpdate = true;
//   String buttonTitle = 'Add';
//   List<Book> playBook = [];
//   List<Book> AudioList = [];
//   TextEditingController controller = new TextEditingController();
//   @override
//   void initState() {
//     play1 = Get.arguments as PlayList;
//     CurrenPlayList = [];

//     for (var i = 0; i < mockPlayList.length; i++) {
//       if (mockPlayList[i].pl_id == play1!.pl_id!) {
//         CurrenPlayList.add(PlayList(pl_audio: mockPlayList[i].pl_audio));
//       }
//     }
//     for (var i = 0; i < mockBookList.length; i++) {
//       if (mockBookList[i].bk_trial == true) {
//         AudioList.add(mockBookList[i]);
//         for (var j = 0; j < play1!.pl_audio!.length; j++) {
//           if (mockBookList[i].bk_ID == play1!.pl_audio![j].ad_ID) {
//             playBook.add(mockBookList[i]);
//           }
//         }
//       }
//       playBook.isNotEmpty
//           ? AudioList.removeWhere((item) => playBook.contains(item))
//           : "";
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var numS = playBook.isNotEmpty ? playBook.length : 0;
//     playBook.isNotEmpty
//         ? AudioList.removeWhere((item) => playBook.contains(item))
//         : "";
//     final theme = Theme.of(context);
//     final themeProv = Provider.of<ThemeProvider>(context);
//     final localprovider = Provider.of<LocaleProvider>(context, listen: true);
//     double widthm = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor:
//             themeProv.isDarkTheme! ? ColorDark.background : Colors.white,
//         body: CustomScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             slivers: [
//               // A flexible app bar
//               SliverAppBar(
//                 backgroundColor: theme.colorScheme.surface,
//                 foregroundColor:
//                     themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
//               ),
//               SliverFillRemaining(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             top: 10.0,
//                             left: 15,
//                             right: 15,
//                             bottom: 10,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10.0),
//                             child: OctoImage(
//                               alignment: Alignment.topLeft,
//                               image: CachedNetworkImageProvider(
//                                 play1!.pl_image!,
//                               ),
//                               fit: BoxFit.cover,
//                               height: 80,
//                               width: 80,
//                               errorBuilder: OctoError.icon(
//                                 color: Theme.of(context).colorScheme.error,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               play1!.pl_title!,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: themeProv.isDarkTheme!
//                                     ? Colors.white
//                                     : ColorDark.background,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   AppLocalizations.of(context)!.playlist,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const Text(
//                                   '  |  ',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$numS ${AppLocalizations.of(context)!.summaries}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 10.0,
//                         right: widthm * 0.1,
//                         left: widthm * 0.1,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 150.0,
//                             height: 45.0,
//                             child: OutlinedButton(
//                               onPressed: () {},
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: ColorLight.primary,
//                                 shape: StadiumBorder(),
//                               ),
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     isUpdate = !isUpdate;
//                                     if (isUpdate == false) {
//                                       buttonTitle =
//                                           AppLocalizations.of(context)!.donee;
//                                     } else {
//                                       buttonTitle =
//                                           AppLocalizations.of(context)!.add;
//                                     }
//                                   });
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                       size: 20.0,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 7.0),
//                                       child: Text(
//                                         buttonTitle,
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 150.0,
//                             height: 45.0,
//                             child: OutlinedButton(
//                               onPressed: () {
//                                 Get.toNamed<dynamic>(Routes.playerList,
//                                     arguments: [
//                                       CurrenPlayList,
//                                       localprovider.localelang!.languageCode
//                                     ]);
//                                 // ignore: omit_local_variable_types
//                                 AudioPlayer? player =
//                                     Provider.of<MyState>(context, listen: false)
//                                         .player;
//                                 // ignore: omit_local_variable_types
//                                 bool? playing =
//                                     Provider.of<MyState>(context, listen: false)
//                                         .isPlaying;
//                                 if (playing != false) {
//                                   player!.dispose();
//                                 } else if (playing == false) {
//                                   player!.dispose();
//                                 }
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 backgroundColor: ColorLight.primary,
//                                 shape: StadiumBorder(),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.play_circle_fill,
//                                     color: Colors.white,
//                                     size: 20.0,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 5.0),
//                                     child: Text(
//                                       AppLocalizations.of(context)!.play,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Center(
//                       child: SizedBox(
//                         width: 350,
//                         child: Divider(
//                           height: 1,
//                           thickness: 1,
//                         ),
//                       ),
//                     ),
//                     if (isUpdate)
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.64,
//                         child: ListView.builder(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           itemCount: playBook.length,
//                           itemBuilder: (context, index) {
//                             final book = playBook[index];

//                             return ShowAudioSumm(book, playBook);
//                           },
//                         ),
//                       )
//                     else
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.64,
//                         child: Column(
//                           children: [
//                             Container(
//                               // color: Theme.of(context).primaryColor,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Card(
//                                   child: ListTile(
//                                     leading: Icon(
//                                       Icons.search,
//                                       color: themeProv.isDarkTheme!
//                                           ? Colors.white
//                                           : ColorDark.background,
//                                     ),
//                                     title: TextField(
//                                       controller: controller,
//                                       decoration: InputDecoration(
//                                           contentPadding: EdgeInsets.only(
//                                               top: localprovider.localelang!
//                                                           .languageCode ==
//                                                       'en'
//                                                   ? 10
//                                                   : 0),
//                                           hintText: localprovider.localelang!
//                                                       .languageCode ==
//                                                   'en'
//                                               ? 'Search'
//                                               : "ابحث",
//                                           hintStyle: TextStyle(
//                                             color: themeProv.isDarkTheme!
//                                                 ? Colors.white
//                                                 : ColorDark.background,
//                                           ),
//                                           border: InputBorder.none),
//                                       onChanged: onSearchTextChanged,
//                                     ),
//                                     trailing: controller.text.isNotEmpty
//                                         ? IconButton(
//                                             icon: Icon(
//                                               Icons.close,
//                                               color: themeProv.isDarkTheme!
//                                                   ? Colors.white
//                                                   : ColorDark.background,
//                                             ),
//                                             onPressed: () {
//                                               controller.clear();
//                                               onSearchTextChanged('');
//                                             },
//                                           )
//                                         : null,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: _searchResult.length != 0 ||
//                                       controller.text.isNotEmpty
//                                   ? ListView.builder(
//                                       itemCount: _searchResult.length,
//                                       itemBuilder: (context, i) {
//                                         final book = _searchResult[i];

//                                         return AddAudioSumm(book);
//                                       },
//                                     )
//                                   : ListView.builder(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       itemCount: AudioList.length,
//                                       itemBuilder: (context, index) {
//                                         Book book;
//                                         String emptyAudioUrl =
//                                             "https://getejaz.com/api/ejaz/v1/Medium/getAudio/00000000-0000-0000-0000-000000000000";

//                                         if (AudioList[index].audioEn !=
//                                                 emptyAudioUrl ||
//                                             AudioList[index].audioAr !=
//                                                 emptyAudioUrl) {
//                                           book = AudioList[index];
//                                           return AddAudioSumm(book);
//                                         } else {
//                                           // Handle case where the URL matches
//                                           return Container(); // Or return any other widget to handle this scenario
//                                         }
//                                       },
//                                     ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ]));
//   }

//   Widget ShowAudioSumm(Book book, List<Book> playBook) {
//     final themeProv = Provider.of<ThemeProvider>(context);
//     final localprovider = Provider.of<LocaleProvider>(context, listen: true);
//     return InkWell(
//       onTap: () {},
//       child: ListTile(
//         textColor: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8.0),
//           child: Image.network(
//             book.imagePath,
//             fit: BoxFit.cover,
//             width: 50,
//             height: 50,
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: 180,
//               child: Text(
//                 localprovider.localelang!.languageCode == 'en'
//                     ? book.bk_Name!
//                     : book.bk_Name_Ar!,
//                 style: const TextStyle(
//                     fontSize: 13, fontWeight: FontWeight.normal, height: 1.2),
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       playBook.removeWhere((item) => item.bk_ID == book.bk_ID);
//                       for (var i = 0; i < play1!.pl_audio!.length; i++) {
//                         CurrenPlayList[0].pl_audio!.removeWhere(
//                             (element) => element.ad_ID == book.bk_ID);
//                       }
//                       setState(() {});
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Colors.grey,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.check,
//                       color: Colors.blue,
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget AddAudioSumm(Book book) {
//     final themeProv = Provider.of<ThemeProvider>(context);
//     final localprovider = Provider.of<LocaleProvider>(context, listen: true);
//     return InkWell(
//       onTap: () {},
//       child: ListTile(
//         textColor: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8.0),
//           child: Image.network(
//             book.imagePath,
//             fit: BoxFit.cover,
//             width: 50,
//             height: 50,
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: 190,
//               child: Text(
//                 localprovider.localelang!.languageCode == 'en'
//                     ? book.bk_Name!
//                     : book.bk_Name_Ar!,
//                 style: const TextStyle(
//                     fontSize: 13, fontWeight: FontWeight.normal, height: 1.2),
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Addaudio(book, localprovider);
//                       setState(() {});
//                     },
//                     icon: const Icon(
//                       Icons.add,
//                       color: Colors.blue,
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // ignore: always_declare_return_types, inference_failure_on_function_return_type
//   Addaudio(Book book, LocaleProvider localprovider) async {
//     List<PlayList> list01 = [];
//     for (var i = 0; i < mockPlayList.length; i++) {
//       if (mockPlayList[i].pl_id == play1!.pl_id!) {
//         mockPlayList[i].pl_audio!.add(Audio(
//             imagePath: book.imagePath,
//             ad_ID: book.bk_ID!,
//             ad_Name: book.bk_Name!,
//             ad_Name_Ar: book.bk_Name_Ar!,
//             ad_Desc: book.bk_Desc!,
//             ad_Desc_Ar: book.bk_Desc_Ar!,
//             ad_Active: book.bk_Active!,
//             ad_source: book.audioEn,
//             ad_source_Ar: book.audioAr));

//         list01.add(PlayList(pl_audio: mockPlayList[i].pl_audio));
//         playBook.add(book);
//       }
//     }
//     CurrenPlayList = list01;
//     await addPlaylist(playlist: mockPlayList, boxName: 'playlist');
//     await Fluttertoast.showToast(
//       webPosition: 'center',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       fontSize: 12,
//       backgroundColor: ColorLight.primary,
//       textColor: Colors.white,
//       msg: localprovider.localelang!.languageCode == 'en'
//           ? 'Added to playlist'
//           : "تمت إضافتها إلى قائمة التشغيل",
//     );
//   }

//   List<Book> _searchResult = [];

//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     final searchLower = text.toLowerCase();

//     AudioList.forEach((Element) {
//       final titleLower = Element.bk_Name!.toLowerCase();
//       if (titleLower.contains(searchLower)) _searchResult.add(Element);
//     });

//     setState(() {});
//   }

//   Future<void> addPlaylist(
//       {required String boxName, required List<dynamic> playlist}) async {
//     var box = await Hive.openBox(boxName);
//     box.put(boxName, playlist);
//     print("WALLPAPER ADICIONADO NO HIVE!");
//     setState(() {});
//   }
// }

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazapp/connectapi/linkapi.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/l10n/app_localizations.dart';

import 'package:ejazapp/data/models/audio.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/data/models/playlist.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/audio_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAudioPlay extends StatefulWidget {
  const AddAudioPlay({super.key});

  @override
  State<AddAudioPlay> createState() => _AddAudioPlayState();
}

class _AddAudioPlayState extends State<AddAudioPlay> {
  PlayList? play1;
  bool isUpdate = true;
  bool buttonTitle = true;
  List<Book> playBook = [];
  List<Book> audioList = [];
  List<Book> Response = [];
  bool isLoading = false; // For tracking loading state
  int currentPage = 1; // For pagination
  int totalPages = 1; // Total pages available from API
  TextEditingController controller = TextEditingController();
  // Declare your ScrollController
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    play1 = Get.arguments as PlayList;
    _loadBooks(); // Load initial books

    // Initialize ScrollController
    _scrollController = ScrollController();

    // Add the listener in initState
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (audioList.isNotEmpty && !isLoading) {
          _loadBooks();
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  // Function to load books from the API
  Future<void> _loadBooks() async {
    if (isLoading || currentPage > totalPages)
      return; // Prevent multiple API calls
    setState(() {
      isLoading = true;
    });

    // Replace with your actual API call for fetching books
    final response = await getBooks(page: currentPage);

    if (response != null) {
      setState(() {
        audioList.addAll(response.books);
        totalPages =
            response.totalPages; // Assuming the response contains total pages
        currentPage++;
      });


     CurrenPlayList = [];

    for (var i = 0; i < mockPlayList.length; i++) {
      if (mockPlayList[i].pl_id == play1!.pl_id!) {
        CurrenPlayList.add(PlayList(pl_audio: mockPlayList[i].pl_audio));
      }
    }
    for (var i = 0; i < audioList.length; i++) {
      if (audioList[i].bk_trial == true) {
       // audioList.remove(audioList[i]);
        for (var j = 0; j < play1!.pl_audio!.length; j++) {
          if (audioList[i].bk_ID == play1!.pl_audio![j].ad_ID) {
            playBook.add(audioList[i]);
          }
        }
      }
      playBook.isNotEmpty
          ? audioList.removeWhere((item) => playBook.contains(item))
          : "";
    }


    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var numS = playBook.isNotEmpty ? playBook.length : 0;
     playBook.isNotEmpty
        ? audioList.removeWhere((item) => playBook.contains(item))
        : "";
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    bool isArabic =localprovider.localelang!.languageCode=="ar";
    double widthm = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor:
            themeProv.isDarkTheme! ? ColorDark.background : Colors.white,
        body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: theme.colorScheme.surface,
                foregroundColor:
                    themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
              ),
              SliverFillRemaining(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: OctoImage(
                              alignment: Alignment.topLeft,
                              image: CachedNetworkImageProvider(
                                play1!.pl_image!,
                              ),
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                              errorBuilder: OctoError.icon(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              play1!.pl_title!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeProv.isDarkTheme!
                                    ? Colors.white
                                    : ColorDark.background,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.playlist,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  '  |  ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$numS ${AppLocalizations.of(context)!.summaries}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        right: widthm * 0.1,
                        left: widthm * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.0,
                            height: 45.0,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorLight.primary,
                                shape: StadiumBorder(),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isUpdate = !isUpdate;
                                    if (isUpdate == false) {
                                      buttonTitle =false;
                                    } else {
                                      buttonTitle =true;
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 10),
                                    Padding(
                                      padding: EdgeInsets.only(top:isArabic?0: 7.0),
                                      child: Text(
                                       buttonTitle==true? AppLocalizations.of(context)!.add:AppLocalizations.of(context)!.donee,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150.0,
                            height: 45.0,
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed<dynamic>(Routes.playerList,
                                    arguments: [
                                      CurrenPlayList,
                                      localprovider.localelang!.languageCode
                                    ]);
                                // ignore: omit_local_variable_types
                                AudioPlayer? player =
                                    Provider.of<MyState>(context, listen: false)
                                        .player;
                                // ignore: omit_local_variable_types
                                bool? playing =
                                    Provider.of<MyState>(context, listen: false)
                                        .isPlaying;
                                if (playing != false) {
                                  player!.dispose();
                                } else if (playing == false) {
                                  player!.dispose();
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorLight.primary,
                                shape: StadiumBorder(),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top:isArabic?0: 5.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.play,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: SizedBox(
                        width: 350,
                        child: Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                    ),
                    if (isUpdate)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.64,
                        child:playBook.isNotEmpty? ListView.builder(
                          padding: const EdgeInsets.only(top: 8.0),
                          itemCount: playBook.length,
                          itemBuilder: (context, index) {
                            final book = playBook[index];
                            return ShowAudioSumm(book, playBook);
                          },
                        ):Center(child: const CircularProgressIndicator(),),
                      )
                    else
                      Container(
                        height: MediaQuery.of(context).size.height * 0.64,
                        child: ListView.builder(
                          controller:
                              _scrollController, // Attach the ScrollController
                          itemCount: audioList.length +
                              1, // +1 for loading indicator at the bottom
                          itemBuilder: (context, index) {
                            if (index == audioList.length) {
                              // Show loading indicator when loading more
                              if (isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container(); // Empty container when not loading
                            }

                            final book = audioList[index];
                            return AddAudioSumm(
                                book); // Your custom widget to display the book
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ]));
  }

  Widget ShowAudioSumm(Book book, List<Book> playBook) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return InkWell(
      onTap: () {},
      child: ListTile(
        textColor: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            book.imagePath,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180,
              child: Text(
                localprovider.localelang!.languageCode == 'en'
                    ? book.bk_Name!
                    : book.bk_Name_Ar!,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal, height: 1.2),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      playBook.removeWhere((item) => item.bk_ID == book.bk_ID);
                       for (var i = 0; i < play1!.pl_audio!.length; i++) {
                        CurrenPlayList[0].pl_audio!.removeWhere(
                            (element) => element.ad_ID == book.bk_ID);
                      }
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget AddAudioSumm(Book book) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return InkWell(
      onTap: () {},
      child: ListTile(
        textColor: themeProv.isDarkTheme! ? Colors.white : ColorDark.background,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            book.imagePath,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 190,
              child: Text(
                localprovider.localelang!.languageCode == 'en'
                    ? book.bk_Name!
                    : book.bk_Name_Ar!,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal, height: 1.2),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Addaudio(book, localprovider);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.playlist_add,
                      color: Colors.blue,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Addaudio(Book book, LocaleProvider localprovider) async {
    List<PlayList> list01 = [];
    for (var i = 0; i < mockPlayList.length; i++) {
      if (mockPlayList[i].pl_id == play1!.pl_id!) {
        mockPlayList[i].pl_audio!.add(Audio(
            imagePath: book.imagePath,
            ad_ID: book.bk_ID!,
            ad_Name: book.bk_Name!,
            ad_Name_Ar: book.bk_Name_Ar!,
            ad_Desc: book.bk_Desc!,
            ad_Desc_Ar: book.bk_Desc_Ar!,
            ad_Active: book.bk_Active!,
            ad_source: book.audioEn,
            ad_source_Ar: book.audioAr));

        list01.add(PlayList(pl_audio: mockPlayList[i].pl_audio));
        playBook.add(book);
      }
    }
    CurrenPlayList = list01;
    await addPlaylist(playlist: mockPlayList, boxName: 'playlist');
    await Fluttertoast.showToast(
      webPosition: 'center',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 12,
      backgroundColor: ColorLight.primary,
      textColor: Colors.white,
      msg: localprovider.localelang!.languageCode == 'en'
          ? 'Added to playlist'
          : "تمت إضافتها إلى قائمة التشغيل",
    );
  }

  List<Book> _searchResult = [];

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    final searchLower = text.toLowerCase();

    audioList.forEach((Element) {
      final titleLower = Element.bk_Name!.toLowerCase();
      if (titleLower.contains(searchLower)) _searchResult.add(Element);
    });

    setState(() {});
  }

  Future<void> addPlaylist(
      {required String boxName, required List<dynamic> playlist}) async {
    var box = await Hive.openBox(boxName);
    box.put(boxName, playlist);
    print("WALLPAPER ADICIONADO NO HIVE!");
    setState(() {});
  }
}

Future<BookResponse> getBooks({required int page}) async {
  String DEFAULT_TOKEN =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYW1laWQiOiI5NDllM2VkNy02YjBhLTQ3ZDItODNlOC00ZWU0MjA4OWQ4OGMiLCJlbWFpbCI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYmYiOjE3NDE3NTk1NTEsImV4cCI6MTc0NDM1MTU1MSwiaWF0IjoxNzQxNzU5NTUxfQ.cR0Yb5xYeoVxjRhO4W13MziuzWJ1vlbP6I3hgL5iZeuTiKfV50calIXVjoDQHw1S-5Zr28r5n85pBZtjaidEQQ";

  try {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? authorized =
      await  sharedPreferences.getString("authorized") ?? DEFAULT_TOKEN;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      "User-Agent": "Ejaz-App/1.0",
      "Connection": "keep-alive",
      'Authorization': 'Bearer $authorized',
    };

    // Correct the URL to use the `page` parameter
    final url = Uri.parse(
        "${AppLink.getbook}PageSize=20&PageNumber=$page&OrderBy=CreationDate&OrderAs=DESC");

    final response = await http
        .get(url, headers: requestHeaders)
        .timeout(Duration(seconds: 60));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Book> newBooks =
          jsonData.map((data) => Book.fromJson(data)).toList();

      // Returning the response in the correct format
      return BookResponse(
          books: newBooks,
          totalPages: 5); // Adjust `totalPages` based on your API response
    } else {
      // handleError(context, response.body.toString());
      return BookResponse(
          books: [], totalPages: 0); // Return an empty list if an error occurs
    }
  } catch (e) {
    // handleError(context, e);
    return BookResponse(
        books: [], totalPages: 0); // Return empty list in case of an exception
  } finally {
    // notifyListeners();
  }
}

class BookResponse {
  final List<Book> books;
  final int totalPages;

  BookResponse({required this.books, required this.totalPages});
}
