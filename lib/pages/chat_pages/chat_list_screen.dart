import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/pages/chat_pages/util.dart';
import 'package:ejazapp/widgets/chat_list/chat_list_tile.dart';
import 'package:ejazapp/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/routes.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat_list/chat_category_button.dart';
import '../../widgets/rectangularButton.dart';
import 'package:ejazapp/l10n/app_localizations.dart';


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int chatCategoryCurrentIndex = 1;
  List<types.User> allUserIds = [];
  List<types.User> _filteredUsers = [];
  String _searchQuery = '';
  bool _isFilteringUnread = false;
  User? _user;
  bool _error = false;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    if (_user!.displayName != null) {
      final room = await FirebaseChatCore.instance.createRoom(otherUser);
      Get.toNamed(Routes.roomChat, arguments: [room, _user]);
    } else {
      await showDialog<dynamic>(
        context: context,
        builder: (context) {
          final themeProv = Provider.of<ThemeProvider>(context);
          final theme = Theme.of(context);
          return AlertDialog(
            backgroundColor:
                themeProv.isDarkTheme! ? ColorDark.card : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              AppLocalizations.of(context)!.are_you_sure,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            content: Text(
              'If you want continue chat with users, please sign in with Google',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.offAllNamed<dynamic>(Routes.signin);
                  await GoogleSignIn().signOut();
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString("token", "");
                  sharedPreferences.setString('name', '');
                  sharedPreferences.setString('phone', '');
                },
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: theme.textTheme.headlineSmall!
                      .copyWith(color: theme.primaryColor),
                ),
              ),
              TextButton(
                onPressed: () => Get.back<dynamic>(),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> filterLastMessages() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('hasUnread', isEqualTo: true)
        .get();

    List<types.User> filteredUsers = [];

    for (var doc in querySnapshot.docs) {
      final userId = doc.id;
      final user = allUserIds.firstWhereOrNull((user) => user.id == userId);
      if (user != null) {
        filteredUsers.add(user);
      }
    }

    setState(() {
      _filteredUsers = filteredUsers;
      _isFilteringUnread = true;
      print('State updated with ${_filteredUsers.length} users');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    Color dividerColor = (themeProv.isDarkTheme ?? false)
        ? ColorDark.divider
        : ColorLight.divider;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SquareButton(
                        child: Icon(Icons.more_horiz),
                        action: () {
                          showMenu(
                            color: theme.cardColor,
                            context: context,
                            position: RelativeRect.fromLTRB(76, 16, 76, 0),
                            items: List.generate(
                              5,
                              (index) => PopupMenuItem(
                                child: Text(
                                  'Text $index',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      SquareButton(
                        action: () {},
                        child: Icon(CupertinoIcons.archivebox_fill),
                      ),
                      const SizedBox(width: 12),
                      SquareButton(
                        action: () {},
                        child: Icon(CupertinoIcons.camera_fill),
                      ),
                      const SizedBox(width: 12),
                      SquareButton(
                        action: () {
                          Get.toNamed(Routes.creategroup,
                              arguments: allUserIds);
                        },
                        child: Icon(Icons.add, color: Colors.white),
                        backGroundColor: theme.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    locale.ejazChat,
                    style:
                        theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: SearchWidget(
                            text: _searchQuery,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value.toLowerCase();
                                _filteredUsers = allUserIds.where((user) {
                                  final name = getUserName(user).toLowerCase();
                                  return name.contains(_searchQuery);
                                }).toList();
                              });
                            },
                            hintText: locale.searchuser,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ChatCategoryButton(
                        text: locale.allChat,
                        isSelected: chatCategoryCurrentIndex == 1,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 1;
                            _filteredUsers = allUserIds; // Reset filter
                          });
                        },
                      ),
                      ChatCategoryButton(
                        text: locale.unreadChat,
                        isSelected: chatCategoryCurrentIndex == 2,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 2;
                          });
                          filterLastMessages(); // Filter unread chats
                        },
                      ),
                      ChatCategoryButton(
                        text: locale.groupChat,
                        isSelected: chatCategoryCurrentIndex == 3,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<types.User>>(
                stream: FirebaseChatCore.instance.users(),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 200),
                      child: const Text('No users'),
                    );
                  }

                  allUserIds = snapshot.data!;
                  final usersToShow = _searchQuery.isNotEmpty
                      ? _filteredUsers
                      : (_isFilteringUnread ? _filteredUsers : allUserIds);

                  return Container(
                    width: double.infinity,
                    color: theme.cardColor,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (context, index) {
                        final user = usersToShow[index];
                        return InkWell(
                          onTap: () {
                            _handlePressed(user, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ChatListTile(
                              index: index,
                              user: user,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Container(height: 0, color: dividerColor),
                      itemCount: usersToShow.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
