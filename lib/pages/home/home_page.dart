import 'dart:io';
import 'dart:typed_data';

import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/banner.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/main.dart';
import 'package:ejazapp/pages/for_you/authors.dart';
import 'package:ejazapp/pages/home/groupes/my_groupes.dart';
import 'package:ejazapp/pages/home/getbookbycategories.dart';
import 'package:ejazapp/pages/home/self_developement/self_developement.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/LoadingListPage.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:ejazapp/widgets/check_update.dart';
import 'package:ejazapp/widgets/custom_elevated_button.dart';
import 'package:ejazapp/widgets/notification_alert.dart';
import 'package:ejazapp/widgets/search_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  // ignore: always_put_required_named_parameters_first
  const HomePage({super.key, required this.controller});
  final BooksApi controller;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  File? file;
  File? file1;
  String? initialMessage;
  int? numNotification = 0;
  List<Book> NewEjaz = [];
  //late String? fullname = Get.arguments.toString();
  int countbanner = 0;
  late List<Book> books;
  late List<BannerIm> banner;
  String query = '';
  late SharedPreferences prefs;
  String? name;
  @override
 @override
@override
void initState() {
  super.initState();
  _initializeApp();
}

void _initializeApp() async {
   await _validateToken();
  // If token is valid, proceed with the rest
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await _fetchData();
    checkForUpdate(context);
  });

  _initializeAppLogic();
}

 _validateToken() async {
  // Replace with your actual token validation logic
   await isTokenExpired() ;
}




void _initializeAppLogic() {
  // Other initializations
  init();
  
  // Initialize localization
  context.read<LocaleProvider>().initState();

  // Initialize Firebase notifications
  initNotifications();
}


  // Prevents duplicate API calls
  isTokenExpired() async {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    // Attempt to refresh the token
    if (booksApi.isTokenExpired()) {
      // Refresh token before making any API call
      await booksApi.refreshToken(context);
    }
  }
//****************************Start function _fetchData() :  ************************/
  Future<void> _fetchData() async {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    try {
      await Future.wait<void>([
        booksApi.getBooksByCreationDate(context),
        booksApi.getAuthors(),
        booksApi.getCategory(),
        // booksApi.GetSubscription(),
        booksApi.GetEjazCollection(),
      ]);
      print("All other APIs completed!");
    } catch (e) {
      print("Error in _fetchData: $e");
    } finally {}
  }

//****************************Start function initNotifications() :  ************************/
  Future<void> initNotifications() async {
    final messaging = FirebaseMessaging.instance;

    final notificationSettings = await messaging.requestPermission();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      const channel = AndroidNotificationChannel(
        'mychannel',
        'title',
        importance: Importance.max,
      );

      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ejaz'),
          iOS: DarwinInitializationSettings(),
          // onSelectNotification: _onSelectNotification)
        ),
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification == null) {
          return;
        }
        setState(() {
          numNotification = numNotification! + 1;
        });
        final notification = message.notification!;
        var data = [];
        final priviousdata = mybox!.get('message');
        if (priviousdata != null) {
          data = mybox!.get('message') as List;
        }
        data.add([
          message.notification!.title,
          message.notification!.body,
          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())
        ]);
        print('message Notification   $notification');

        mybox!.put('message', data);

        if (notification.android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ),
          );
        }

        // Show Popup Dialog
        if (navigatorKey.currentContext != null) {
          showNotificationDialog(navigatorKey.currentContext!,
              notification.title, notification.body);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // do something with message
        print('A new onMessageOpenedApp event was published!');
        // Get.toNamed(Routes.notification, arguments: message);
        final notification = message.notification;
        var data = [];
        final priviousdata = mybox!.get('message');
        if (priviousdata != null) {
          data = mybox!.get('message') as List;
        }
        data.add([
          message.notification!.title,
          message.notification!.body,
          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())
        ]);
        print('message Notification   $notification');

        mybox!.put('message', data);
        print('message Notification $notification');

        setState(() {
          numNotification = numNotification! + 1;
        });
        // Show Popup Dialog
        if (navigatorKey.currentContext != null) {
          showNotificationDialog(navigatorKey.currentContext!,
              message.notification!.title, message.notification!.body);
        }
      });

      await messaging.getInitialMessage().then((RemoteMessage? message) {
        if (message == null) {
          return;
        }
      });
    }
  }
//****************************End function initNotifications() :  ************************/

//**************************** function init() : set book list and show banner after 7 second ************************/
  Future init() async {
    setState(() {
      books = mockBookList;
      banner = getbannerList;
    });

    if (getbannerList.isNotEmpty) {
      Future.delayed(const Duration(seconds: 7), () {
        getbannerList[0].bnActive == true ? showPopup() : '';
      });
    }

    final data = mybox!.get('photo');
    if (data != null) {
      final bytesdata = ByteData.view(data.buffer as ByteBuffer);
      inittofile(bytesdata);
    }
  }

  writeToFile(ByteData data) async {
    var uid = Uuid().v4();
    final buffer = data.buffer;
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final filePath = '$tempPath/image ' +
        uid.split('-')[0] +
        '.jpeg'; // // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  inittofile(ByteData bytesdata) async {
    try {
      file1 = await writeToFile(bytesdata) as File; // <= returns File
      setState(() {
        file = file1;
      });
    } catch (e) {
      // catch errors here
    }
  }
//**************************** function _handleTabSelection() : ************************/

//**************************** function searchBook() : ************************/

  void searchBook(String query) async {
    final queryParam =
        Uri.encodeComponent(query); // Encode query to handle spaces
    setState(() {
      this.query = query;
    });
    // Construct API URL to search by title and author
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    await booksApi.searchBookQuery(queryParam);

    setState(() {
      this.query = query;
      this.books = booksApi.booksQuery;
    });
  }

  void showPopup() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ignore: inference_failure_on_function_invocation
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              SizedBox(
                height: 40,
                child: Center(
                  child: FloatingActionButton(
                    elevation: 1,
                    foregroundColor: const Color.fromARGB(255, 237, 239, 242),
                    backgroundColor: ColorDark.background,
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close app',
                    child: const Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(
              top: 150,
              bottom: 100,
              left: 50,
              right: 50,
            ),
            content: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: Lottie.asset(
                    Const.backpopup,
                    // width: double.maxFinite,
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: OctoImage(
                        image: CachedNetworkImageProvider(
                          getbannerList.length > 0
                              ? getbannerList[0].imagePath ?? Const.nodata
                              : Const.noarrival,
                        ),
                        fit: BoxFit.cover,
                        width: 150,
                        errorBuilder: OctoError.icon(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 280),
                    child: Text(
                      getbannerList.length > 0
                          ? getbannerList[0].bnTitle.toString()
                          : 'New arrival will be apear here',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 370,
                      left: 14,
                      right: 14,
                    ),
                    child: Text(
                      getbannerList.length > 0
                          ? getbannerList[0].bnDesc.toString()
                          : 'New arrival will be apear here',
                      style: const TextStyle(fontSize: 14, height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Book> getLastNBooksAdded(List<Book> books, int n) {
    // Sort the list by addedAt in descending order (most recent first)
    books.sort((a, b) => DateTime.parse(b.bk_CreatedOn!)
        .compareTo(DateTime.parse(a.bk_CreatedOn!)));

    // Return the first N books, or the whole list if N is larger than the list length
    return books.take(n).toList();
  }

  List<Widget> _homeTabBarList(BuildContext context) => [
        //  Tab(text: AppLocalizations.of(context)!.all),
        Tab(text: AppLocalizations.of(context)!.biography),
        Tab(text: AppLocalizations.of(context)!.business),
        Tab(text: AppLocalizations.of(context)!.culture),
        Tab(text: AppLocalizations.of(context)!.health),
        Tab(text: AppLocalizations.of(context)!.history),
        Tab(text: AppLocalizations.of(context)!.politics),
        Tab(text: AppLocalizations.of(context)!.novel),
        Tab(text: AppLocalizations.of(context)!.science),
        Tab(text: AppLocalizations.of(context)!.self_developement),
        Tab(text: AppLocalizations.of(context)!.others),
      ];
//**************************** Start of function SearchWidget() : ************************/
  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: AppLocalizations.of(context)!.search_your_favorite_book,
        onChanged: searchBook,
      );
//**************************** End of function SearchWidget() : ************************/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        buildMainContent(context),
        buildCollapseAppBar(theme),
      ],
    );
  }

  Positioned buildCollapseAppBar(ThemeData theme) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localeProv = Provider.of<LocaleProvider>(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: theme.colorScheme.surface,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: numNotification != 0 ? 15 : 0,
                left: numNotification != 0 ? 8 : 0,
                right: numNotification != 0 ? 8 : 0),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.notification);
                setState(() {
                  numNotification = 0;
                });
              },
              child: numNotification != 0
                  ? badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -15, end: -12),
                      badgeContent: Padding(
                        padding: localeProv.localelang!.languageCode == 'en'
                            ? const EdgeInsets.only(top: 5)
                            : const EdgeInsets.all(0),
                        child: Text(
                          '$numNotification',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      badgeAnimation: const badges.BadgeAnimation.slide(
                        curve: Curves.easeInCubic,
                      ),
                      child: Icon(
                        Feather.mail,
                        color:
                            themeProv.isDarkTheme! ? Colors.grey : Colors.grey,
                      ),
                    )
                  : Icon(
                      Feather.mail,
                      color: themeProv.isDarkTheme! ? Colors.grey : Colors.grey,
                    ),
            ),
          ),
          const SizedBox(width: Const.margin),
        ],
      ),
    );
  }

  Positioned buildMainContent(BuildContext context) {
    // Get current time and determine the appropriate greeting
    String message = _getGreetingMessage(context);

    // Retrieve user and app settings
    final localeProvider = Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLoading = Provider.of<BooksApi>(context).isLooding;
    final width = MediaQuery.of(context).size.width;

    // Fetch latest books
    NewEjaz = getLastNBooksAdded(LastBooks, 10);

    return Positioned.fill(
      child: NestedScrollView(
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header section
              _buildHeader(
                  context, message, localeProvider, theme, themeProvider),

              const SizedBox(height: 3),
              const SizedBox(height: 10),

              // Search bar container
              _buildSearchBar(context, theme),

              // Conditional content rendering
              query.isEmpty
                  ? _buildDefaultContent(isLoading, localeProvider, theme)
                  : _buildSearchResults() // else case should return a widget
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

  String _getGreetingMessage(BuildContext context) {
    final int hour = DateTime.now().hour;
    if (hour >= 0 && hour <= 12) {
      return AppLocalizations.of(context)!.good_morning;
    } else if (hour >= 13 && hour <= 18) {
      return AppLocalizations.of(context)!.good_afternoon;
    } else {
      return AppLocalizations.of(context)!.good_evening;
    }
  }

  Widget _buildHeader(
      BuildContext context,
      String message,
      LocaleProvider localeProvider,
      ThemeData theme,
      ThemeProvider themeProvider) {
    final String name = localeProvider.localelang!.languageCode == 'en'
        ? mybox!.get('name') ?? ""
        : '';

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: Const.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$message $name',
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!
                        .today_is_a_new_day_for_knowledge,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: themeProvider.isDarkTheme!
                          ? Colors.white54
                          : Colors.black45,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              _buildProfileImage(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 56,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.profile);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: (file == null)
              ? const CachedNetworkImageProvider(
                  'https://cdn.shopify.com/s/files/1/0747/0491/2661/files/profile.png?v=1691401880',
                )
              : FileImage(file!) as ImageProvider<
                  Object>?, // Cast the FileImage to ImageProvider<Object>

          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ThemeData theme) {
    return Container(
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
    );
  }

  Widget _buildDefaultContent(
      bool isLoading, LocaleProvider localeProvider, ThemeData theme) {
    if (isLoading) return const LoadingListPage();
// Instantiate BooksApi
    final BooksApi booksApiController = BooksApi();
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildRecommendedSection(localeProvider, theme),
        const SizedBox(height: 5),
        HomePageTabBar(controller: booksApiController),
        const SizedBox(height: 20),
        _buildQuoteSection(theme),
        const SizedBox(height: 30),
        _buildContinueReadingSection(localeProvider, theme),
        const SizedBox(height: 30),

        // New Ejaz Books Section
        SizedBox(
          width: double.infinity,
          height: 260,
          child: NewEjaz.isNotEmpty
              ? ListView.builder(
                  itemCount: NewEjaz.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: Const.margin),
                  itemBuilder: (context, index) {
                    return BookCard(book: NewEjaz[index]);
                  },
                )
              : Center(child: CircularProgressIndicator()),
        ),

        _buildSelfDevelopmentSection(localeProvider, theme),
        const SizedBox(height: 5),
        const SelfDevelopent(category: ''),

        const SizedBox(height: 10),
        _buildTopAuthorsSection(localeProvider, theme),
        const AuthorsExplore(),

        _buildGroupesSection(localeProvider, theme),
        const MyGroupes(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRecommendedSection(
      LocaleProvider localeProvider, ThemeData theme) {
    return buildSettingApp(
      context,
      title: AppLocalizations.of(context)!.recommended,
      style: theme.textTheme.headlineLarge,
      trailing: Padding(
        padding: localeProvider.localelang!.languageCode == 'en'
            ? const EdgeInsets.only(top: 8.0, right: 3)
            : const EdgeInsets.only(top: 8.0, left: 3),
        child: Text(
          localeProvider.localelang!.languageCode == 'en'
              ? "View All"
              : "عرض الكل",
          style: TextStyle(color: ColorLight.primary),
        ),
      ),
      onTap: () {
        Get.toNamed<dynamic>(Routes.fetchallbooks,
            arguments: ['', 'lastbook', '']);
      },
    );
  }

  Widget _buildQuoteSection(ThemeData theme) {
    final localprovider = Provider.of<LocaleProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: Const.margin, right: Const.margin),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(Const.maskgrouphome),
                fit: BoxFit.cover,
              ),
            ),
            height: 200,
            width: double.infinity,
            child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: localprovider.localelang!.languageCode == 'en'
                        ? 12
                        : width * 0.032, // adjust as needed
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(
                          top: 15,
                          right: localprovider.localelang!.languageCode == 'ar'
                              ? width * 0.38
                              : 0,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.quote_of_day,
                          maxLines: 2,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            height: 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            AppLocalizations.of(context)!.the_true_sign,
                            style: const TextStyle(
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                              wordSpacing: 1,
                              height: 1.2,
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, right: width * 0.38),
                        child: MyRaisedButton(
                          color: const Color(0xFF0088CE),
                          width: width * 0.5,
                          onTap: OpenApp,
                          label: AppLocalizations.of(context)!.suggetion,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueReadingSection(
      LocaleProvider localeProvider, ThemeData theme) {
    return buildSettingApp(
      context,
      title: AppLocalizations.of(context)!.continue_reading,
      style: theme.textTheme.headlineLarge,
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 3),
        child: Text(
          localeProvider.localelang!.languageCode == 'en'
              ? "View All"
              : "عرض الكل",
          style: TextStyle(color: ColorLight.primary),
        ),
      ),
      onTap: () {
        Get.toNamed<dynamic>(
          Routes.allitem,
          arguments: ['', 'lastbook', 'newejaz'],
        );
      },
    );
  }

  Widget _buildSelfDevelopmentSection(
      LocaleProvider localeProvider, ThemeData theme) {
    return buildSettingApp(
      context,
      title: AppLocalizations.of(context)!.self_developement,
      style: theme.textTheme.headlineLarge,
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 3),
        child: Text(
          localeProvider.localelang!.languageCode == 'en'
              ? "View All"
              : "عرض الكل",
          style: TextStyle(color: ColorLight.primary),
        ),
      ),
      onTap: () {
        Get.toNamed<dynamic>(
          Routes.fetchallbooks,
          arguments: ['', 'lastbook', 'Self Development'],
        );
      },
    );
  }

  Widget _buildTopAuthorsSection(
      LocaleProvider localeProvider, ThemeData theme) {
    return buildSettingApp(
      context,
      title: AppLocalizations.of(context)!.top_authors,
      style: theme.textTheme.headlineLarge,
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 3),
        child: Text(
          localeProvider.localelang!.languageCode == 'en'
              ? "View All"
              : "عرض الكل",
          style: TextStyle(color: ColorLight.primary),
        ),
      ),
      onTap: () {
        Get.toNamed<dynamic>(Routes.listauthors);
      },
    );
  }

  Widget _buildGroupesSection(LocaleProvider localeProvider, ThemeData theme) {
    return buildSettingApp(
      context,
      title: AppLocalizations.of(context)!.mygroupes,
      style: theme.textTheme.headlineLarge,
      trailing: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 3),
          child: Container()),
      onTap: () {},
    );
  }

  Widget _buildSearchResults() {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          if (index == books.length) {
            return Center(child: CircularProgressIndicator());
          }
          final book = books[index];
          return buildBook(book);
        },
      ),
    );
  }

  Widget buildBook(Book book) {
    final localprovider = Provider.of<LocaleProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        // if (book.bk_trial! != true) {
        //   PaymentDo(context);
        //   return;
        // }
        Get.toNamed<dynamic>(
          Routes.bookdetail,
          arguments: [
            book,
            '',
            localprovider.localelang!.languageCode,
            "search"
          ],
        );
      },
      child: ListTile(
        leading: SizedBox(
          width: 70,
          height: 70,
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  book.url != null ? book.url! : "",
                  fit: BoxFit.contain,
                ),
              )),
        ),
        title: Text(
          localprovider.localelang!.languageCode == 'en'
              ? book.bk_Title!
              : book.bk_Title_Ar!,
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
