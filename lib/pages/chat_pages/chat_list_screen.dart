import 'package:ejazapp/helpers/colors.dart';

import 'package:ejazapp/pages/chat_pages/util.dart';
import 'package:ejazapp/widgets/chat_list/chat_list_tile.dart';
import 'package:ejazapp/widgets/search_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/routes.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat_list/chat_category_button.dart';
import '../../widgets/rectangularButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int chatCategoryCurrentIndex = 1;
   List<types.User> allUserIds=[];
  User? _user;
  bool _error = false;
  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(
        right: 16,
      ),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

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
      final navigator = Navigator.of(context);
      final room = await FirebaseChatCore.instance.createRoom(otherUser);
      Get.toNamed(Routes.roomChat,arguments: [room,_user]);
     
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
              // AppLocalizations.of(context)!
              //     .if_you_select_log_out_it_will_return_to_the_login_screen,
              'If you want contuine chat with users,please sign in with google ',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.offAllNamed<dynamic>(Routes.signin);
                  await GoogleSignIn().signOut();
                  //  await ;
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

  @override
  Widget build(BuildContext context) {
   
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    Color dividerColor = (themeProv.isDarkTheme ?? false)
        ? ColorDark.divider
        : ColorLight.divider;

    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
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
                                )),
                              ));
                        },
                      ),
                      const Spacer(),
                      SquareButton(
                         action:(){},
                          child: Icon(
                        CupertinoIcons.archivebox_fill,
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      SquareButton(
                        action:(){},
                        child: Icon(CupertinoIcons.camera_fill)),
                      const SizedBox(
                        width: 12,
                      ),
                      SquareButton(
                        action:(){
                          
                          Get.toNamed(Routes.creategroup,arguments: allUserIds);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backGroundColor: theme.primaryColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    locale.ejazChat,
                    style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: SearchWidget(
                                text: '',
                                onChanged: (value) {},
                                hintText: locale.search),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    //spacing: 12,
                    children: [
                      ChatCategoryButton(
                        text: locale.allChat,
                        isSelected: chatCategoryCurrentIndex == 1,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 1;
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
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: StreamBuilder<List<types.User>>(
              stream: FirebaseChatCore.instance.users(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No users'),
                  );
                }
               allUserIds=snapshot.data!;
               print("allUserIds ${allUserIds}");
                return Container(
                    width: double.infinity,
                    color: theme.cardColor,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                      ),
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        
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
                            ));
                      },
                      separatorBuilder: (context, index) =>
                          Container(height: 1, color: dividerColor),
                      itemCount: snapshot.data!.length,
                    ));
              },
            )),
          ],
        ),
      ),
    );
  }
}
